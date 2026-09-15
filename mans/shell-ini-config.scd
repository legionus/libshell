shell-ini-config(3)

# NAME
ini_config_get, ini_config_is_set, ini_config_set, ini_config_del,
ini_config_comment - functions for operating on INI-style configuration
files.

# SYNOPSIS
- ini_config_get file section var
- ini_config_is_set file section var
- ini_config_set file section var value
- ini_config_del file section [var]
- ini_config_comment file section [var]

# DESCRIPTION
Helpers for reading and modifying INI-style configuration files:
files made of `[section]` headers followed by var = value lines.
The comment character is `#` (configurable through the
*shell_ini_config_comment* variable). All
functions expect *file* to exist and print a message and return
non-zero otherwise; *ini_config_set* will not create a missing file.

## ini_config_get
Prints the value of *var* in the first `[section]` block of *file* to
standard output. The lookup stops at the first match. When no entry is
found the function prints nothing and still returns 0; use
*ini_config_is_set* to distinguish a missing entry from an empty
value.

Example:
```
ini_config_get /etc/app.ini network host
# localhost
```

## ini_config_is_set
Returns 0 when *var* occurs in the *section* of *file* and 1
otherwise.

Example:
```
if ini_config_is_set /etc/app.ini network host; then
    echo "host is configured"
fi
```

## ini_config_set
Sets *var* to *value* inside `[section]`. When the entry already
exists, all its occurrences are replaced in place; when it does not
exist the line is inserted at the end of the section, and the section
itself is appended at the end of the file if it is missing. The file
permissions are preserved.

Note that commenting an entry out does not make *ini_config_set*
uncomment it: a new active line is appended to the section, as shown
below.

Example:
```
ini_config_set /etc/app.ini network host "10.0.0.5"

# new entry in an existing section
ini_config_set /etc/app.ini network timeout 30

# creates the [logging] section at the end
ini_config_set /etc/app.ini logging level debug
```

## ini_config_del
Removes one or all entries of *section*. When *var* is supplied, only
that entry is removed; otherwise every entry of the section is
removed. The section header itself is preserved in both cases, so an
empty section block may remain in the file.

Example:
```
ini_config_del /etc/app.ini network timeout

# remove everything under [logging]
ini_config_del /etc/app.ini logging
```

## ini_config_comment
Comments out one or all entries of *section* by prepending the
comment character. When *var* is supplied, only that entry is
commented; otherwise every entry of the section is commented.

Example:
```
ini_config_comment /etc/app.ini logging level

# comment every entry of [logging]
ini_config_comment /etc/app.ini logging
# [logging]
# # level = debug
```

# NOTES
All functions treat a line that begins with the comment character as
a comment, and blank lines as separators. Section names and entry
names are compared literally; matching is case-sensitive.

*ini_config_set* replaces the file atomically through *mv(1)* and
preserves the original file mode.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
