% SHELL-QUOTE
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

quote_sed_regexp, quote_sed_regexp_variable, quote_shell, quote_shell_args, quote_shell_variable

# SYNOPSIS #

- quote_sed_regexp
- quote_sed_regexp_variable
- quote_shell
- quote_shell_args
- quote_shell_variable

# DESCRIPTION #
Collection of functions to quote variables. The goal of functions to provide quoted values for
`sed`, `sh` or for safe `eval` inside script.

## quote_sed_regexp ##
Function quotes given arguments for sed basic regular expression.
Usage example:
```bash
sed "s/$(quote_sed_regexp "$var_pattern")/$(quote_sed_regexp "$var_replacement")/"
```

## quote_sed_regexp_variable ##
Function quotes argument for sed basic regular expression and stores result into variable.
Usage example:
```bash
quote_sed_regexp_variable var_pattern "$pattern"
quote_sed_regexp_variable var_replace "$replace"
sed "s/$var_pattern/$var_replace/"
```

## quote_shell ##
Function quotes argument for shell.
Usage example: 
```bash
eval "$var_name=\"$(quote_shell "$var_value")\""
```

## quote_shell_variable ##
Function quotes argument for shell and stores result into variable.
Usage example:
```bash
quote_shell_variable var_name "$var_value"
printf '%s\n' "$var_name"
```

## quote_shell_args ##
Function quotes argument for shell and stores result into variable.
Usage example:
```bash
quote_shell_args args "$var_args"
eval "set -- $args"
```

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

