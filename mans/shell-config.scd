shell-config(3)

# NAME
shell_config_get, shell_config_set, shell_config_del, shell_config_comment
- functions for operating on a shell-style configuration file.

# SYNOPSIS
- shell_config_get file name [delim]
- shell_config_set file name value [read-delim [write-delim]]
- shell_config_del file name [delim]
- shell_config_comment file name [delim]

# DESCRIPTION
Helpers for reading, writing, commenting and removing entries of a
shell-style configuration file, that is, a file organized as one
name=value entry per line. Under the hood the functions use *sed*
and *grep*. The reading functions behave appropriately when *file*
does not exist, and *shell_config_set* creates *file* on first use.

## shell_config_get
Looks for the line matching *name* in *file* and prints the value part
(what follows *delim*) to standard output. When *name* is not present
(no matching, not commented out) the function prints nothing. Returns
0 on success and non-zero on error.

Example:
```
shell_config_set /tmp/cfg name "Alice"
shell_config_get /tmp/cfg name      # Alice
```

## shell_config_set
Updates the entry named *name* in *file* to the new *value*. If the
line already exists it is replaced in place; if a commented-out form
of the line is found it is uncommented. A brand-new file is created
when *file* does not exist.

*read-delim* determines the separator used when reading an existing
line (default '='). *write-delim* determines the separator used when
the line is written (default '='). The two can differ, allowing a
single invocation to both read a `name=value` line and write it back
as `name:value`.

Example:
```
# update an existing entry in place
shell_config_set /etc/network/interfaces eth0.address 10.0.0.7

# create a new file
shell_config_set /tmp/cfg name Alice

# switch a value separator on the fly
shell_config_set /tmp/cfg name Alice "=" ":"
grep name /tmp/cfg                 # name:Alice
```

## shell_config_del
Removes all (not commented-out) lines whose leading token matches
*name* from *file*.

Example:
```
shell_config_set /tmp/cfg name Alice
shell_config_set /tmp/cfg other "discard me"
shell_config_del /tmp/cfg other
cat /tmp/cfg                       # name=Alice
```

## shell_config_comment
Rewrites every (not already commented-out) line whose leading token
matches *name* so that the line is preceded by the shell comment
prefix. This is the inverse of the un-comment behavior of
*shell_config_set*.

Example:
```
shell_config_set /tmp/cfg name Alice
shell_config_comment /tmp/cfg name
cat /tmp/cfg                       # #name=Alice
```

# NOTES
All functions accept a *delim* argument (or *read-delim* and
*write-delim* for *shell_config_set*) to operate on configuration
files that use a different name/value separator. The default is '='.

Functions are intended for shell-style config files and expect
*file* to be a plain text file with one `name=value` entry per line.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
