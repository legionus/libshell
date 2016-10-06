% SHELL-CMDLINE
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

cmdline_foreach, cmdline_get - parses and get values from `/proc/cmdline`

# SYNOPSIS #

- cmdline_foreach "proc-cmdline-data" "handler-function"
- cmdline_get "name-for-result" "name" ["proc-cmdline-data"]

# DESCRIPTION #
Collection of functions to parse and get values from `/proc/cmdline`. Because `/proc/cmdline` isn't
just shell command line we need to parse it differently. This string can have repetitions of parameters,
and only the last value makes sense, parameter names may contain characters illegal characters
for variables in a shell.

## cmdline_foreach ##
Function runs **handler-function** for each variable in **proc-cmdline-data**.
Returns nothing.

## cmdline_get ##
Function finds specified by **name** variable in `/proc/cmdline` or in **proc-cmdline-data**
and stores result into variable passed by **name-for-result**.
Usage example:

```bash
read cmdline < /proc/cmdline
cmdline_get 'initrd_value' 'initrd' "$cmdline"
echo "$initrd_value"
```

or

```bash
cmdline_get 'initrd_value' 'initrd'
echo "$initrd_value"
```

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

