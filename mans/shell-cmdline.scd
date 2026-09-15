shell-cmdline(3)

# NAME
cmdline_foreach, cmdline_get - functions for parsing kernel command line
data.

# SYNOPSIS
- cmdline_foreach cmdline handler
- cmdline_get resultvar name [cmdline]

# DESCRIPTION
Helpers for processing the kernel command line, the data normally held
in *proc/cmdline*. The command line is a whitespace-separated sequence
of tokens, each either name=value or a bare flag name; a leading dash
in a token name is normalized to an underscore.

## cmdline_foreach
Calls *handler* once for every token in *cmdline*. The handler is
invoked as *handler name value first*: *name* is the token name;
*value* is the text following the equals sign, or the literal value
1 when the token is a bare flag with no equals sign; *first* is 1
when the token carries no equals-sign value and empty otherwise.
Processing stops as soon as the handler returns a non-zero status.

Example:
```
show() { echo "name=$1 value=$2 first=$3"; }
cmdline_foreach "initrd=/x quiet other=yes" show
# name=initrd value=/x first=
# name=quiet value=1 first=1
# name=other value=yes first=
```

## cmdline_get
Looks up the token named *name* in *cmdline* (by default, in
*proc/cmdline*) and assigns its value to the variable *resultvar*.
When the token occurs several times, the last occurrence wins. If
*name* is not present, *resultvar* is left unchanged.

Example:
```
cmdline_get initrd_value initrd "initrd=/first initrd=/second quiet"
echo "$initrd_value"        # /second

cmdline_get other_value other "quiet=1"
echo "[$other_value]"       # []
```

# NOTES
Both functions operate on ordinary shell strings; they are intended
to be pointed at the contents of *proc/cmdline* but can be used for
any compatible tokenized string.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
