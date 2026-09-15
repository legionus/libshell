shell-string(3)

# NAME
fill_mask - function to build a per-character iteration mask.

# SYNOPSIS
- fill_mask result_var str

# DESCRIPTION

## fill_mask
Builds a mask of *?* characters whose length is the number of
characters in *str* minus one, and assigns the result to the variable
named by *result_var*. This helper is used by the character iteration
functions in *libshell* to walk a string one character at a time in
POSIX shells that do not support the *bash*-specific character
indexing expression.

Example:
```
fill_mask M hello
echo "$M"            # ???

fill_mask M ab
echo "$M"            # ?
```

# NOTES
*fill_mask* is intended as an internal building block for the
per-character iteration helpers and is not meant for general string
processing.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
