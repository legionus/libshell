shell-git-config(3)

# NAME
git_config_append, git_config_count, git_config_get, git_config_list,
git_config_location_exists, git_config_parse, git_config_parse_file,
git_config_set, git_config_unset, git_config_env, git_config_get_var,
git_config_foreach, git_config_get_subsections - functions for reading
and modifying git-style configuration files.

# SYNOPSIS
- git_config_append file name value
- git_config_count retname file name
- git_config_get retname file name
- git_config_list file [name]
- git_config_location_exists file name
- git_config_parse file
- git_config_set file name value
- git_config_unset file name [value]
- git_config_env file
- git_config_get_var retname section subsection name {first|last|all=DELIM}
- git_config_foreach [name] [handler]
- git_config_get_subsections section

# DESCRIPTION
A collection of helpers for operating on git-style configuration
files, as described by *git-config(1)*. The configuration file groups
entries into sections; the fully qualified name of an entry is the
section name (optionally followed by a "subsection"), a dot, and the
entry name. Names are case-insensitive. Some entries (for example
*alias* and *fetch*) may legitimately appear more than once; such
entries are *multivalued*.

The first group of functions parses the configuration file on every
call. The second group (introduced by *git_config_env*) reads the
file once into memory, so that repeated lookups are faster; the
in-memory form exposes the extra functions *git_config_get_var*,
*git_config_foreach* and *git_config_get_subsections*.

## git_config_append
Appends one more *value* to the multivalued entry *name* of *file*.
If the entry is not already present or does not contain other values
with the same name, a new *name* line is added to the section.

Example:
```
git_config_append .git/config alias.st "status -sb"
git_config_list .git/config alias.st
# status -sb
```

## git_config_count
Counts the number of occurrences of the entry *name* in *file* and
stores the count in the variable *retname*.

Example:
```
n=
git_config_count n .git/config remote.origin.fetch
echo "$n"
```

## git_config_get
Stores the last value of entry *name* found in *file* into the
variable *retname*. Returns 0 even when the entry is not found, in
which case *retname* is left empty.

Example:
```
email=
git_config_get email .git/config user.email
echo "$email"
```

## git_config_list
Prints every value of *name* in *file*, one per line. When *name* is
omitted, prints all entries as `name=value`.

Example:
```
git_config_list .git/config
# user.name=John
# remote.origin.url=git@example.com:repo.git

git_config_list .git/config remote.origin.fetch
# +refs/heads/*:refs/remotes/origin/*
```

## git_config_location_exists
Returns 0 when the entry *name* is present in *file*, non-zero
otherwise.

Example:
```
git_config_location_exists .git/config user.email &&
    echo "email is set"
```

## git_config_parse
Prints every entry of *file* as `name<TAB>value` (one per line),
suitable for `eval`-based iteration.

Example:
```
git_config_parse .git/config
# user.name	Jon
# user.email	jon@example.com
```

## git_config_parse_file
The low-level parser. Reads *file* and invokes the handler function
*git_config_handler* for every entry (section start, comment,
variable and so on). Most callers should use the wrapper functions
listed above.

## git_config_handler
Default handler used by *git_config_parse_file*. Provided as a place
to plug custom behavior; the wrapper functions temporarily override
it.

## git_config_set
Updates the entry *name* of *file* to *value*, replacing any previous
values. When the section does not exist yet, it is created.

Example:
```
git_config_set .git/config user.email "john@example.com"
git_config_get e .git/config user.email
echo "$e"         # john@example.com
```

## git_config_unset
Removes the entry *name* from *file*. When a multivalued *value*
argument is supplied, only that particular value is removed and the
other values of the entry are preserved.

Example:
```
git_config_set .git/config alias.tmp "co --stat"
git_config_set .git/config alias.tmp "log --oneline"
git_config_unset .git/config alias.tmp "co --stat"
git_config_list .git/config alias.tmp        # log --oneline
```

## git_config_env
Reads *file* and stores its entries into shell variables so that the
*git_config_get_var*, *git_config_foreach* and
*git_config_get_subsections* functions can be used afterwards. This
is more memory-hungry than the on-demand functions but much faster
when many values are requested.

Example:
```
git_config_env .git/config
git_config_get_var n user '' name last
echo "$n"
```

## git_config_get_var
Look up the entry *section[.subsection].name* in the file previously
parsed by *git_config_env* and store the result in *retname*.
The trailing argument selects which occurrence to use: *first*,
*last* (the default), or *all=DELIM* to collect every value into a
single string separated by *DELIM*.

Example:
```
all=
git_config_get_var all remote origin fetch all=,
echo "$all"
```

## git_config_foreach
Walks over every entry of a previously parsed configuration (via
*git_config_env*) and invokes the *handler* function (default
*git_config_foreach_handler*) as *handler name value*. When *name*
is given, only entries matching the full qualified name are handed to
the handler.

Example:
```
git_config_env .git/config
show() { echo "  $1 = $2"; }
git_config_foreach '' show
```

## git_config_foreach_handler
Default handler invoked by *git_config_foreach*: prints each entry
as name=value to *stdout*. May be overridden by the caller.

## git_config_get_subsections
For each subsection recorded in the parsed configuration under
*section*, invoke the (overridable) *git_config_get_subsections_handler*
with the subsection name as its argument.

Example:
```
git_config_env .git/config
git_config_get_subsections_handler() { echo "  $1"; }
git_config_get_subsections remote
```

## git_config_get_subsections_handler
Default handler invoked by *git_config_get_subsections*: a no-op.
May be overridden by the caller.

# NOTES
The *handler* and *retname* functions above operate on the in-memory
copy created by *git_config_env*. They require that *git_config_env*
has been called for the desired file before the first lookup.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
