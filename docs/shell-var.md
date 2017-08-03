% SHELL-VAR
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

shell_var_is_no, shell_var_is_yes, shell_var_is_number, shell_var_trim, shell_var_unquote - functions
to trim spaces in the value of the variable

# SYNOPSIS #

- shell_var_trim varname value
- shell_var_unquote varname value
- shell_var_is_no value
- shell_var_is_yes value
- shell_var_is_number

# DESCRIPTION #

## shell_var_trim ##
Function strips whitespace from the beginning and end of a string

Example:
```bash
shell_var_trim retval "   aaa bb  aaa "; echo "[$retval]"
[aaa bb  aaa]
```

## shell_var_unquote ##
Function removes quote symbol from string

Example:
```bash
for i in "\"str1\"" "'str2'" "\"str3'"; do
    shell_var_unquote var "$i";
    echo "$var";
done
```
Output:
```
str1
str2
"str3'
```

## shell_var_is_no ##
Function checks whether the variable means "no".

## shell_var_is_yes ##
Function checks whether the variable means "yes".

## shell_var_is_number ##
Function checks whether the variable is positive number.

Example:
```bash
shell_var_is_number '123' && echo OK || echo NOP
shell_var_is_number '420' && echo OK || echo NOP
shell_var_is_number 'a42' && echo OK || echo NOP
shell_var_is_number '2 0' && echo OK || echo NOP
```
Output:
```
OK
OK
NOP
NOP
```

# ENVIRONMENT #

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

