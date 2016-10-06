% SHELL-CONFIG
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

shell_config_comment, shell_config_del, shell_config_get, shell_config_set - functions
to work with a shell-like config files.

# SYNOPSIS #

- shell_config_comment "file" "name" ["delim"]
- shell_config_del "file" "name" ["delim"]
- shell_config_get "file" "name" ["delim"]
- shell_config_set "file" "name" "value" ["read-delim" ["write-delim"]]

# DESCRIPTION #
functions to work (read, change and remove variables) with a shell-like config files.

## shell_config_comment ##
Function puts **name** variable under comment in the config **file**.
Optionally, you can define custom delimeter between name and value.

## shell_config_del ##
Function removes all entries (not commented) of **name** variable in the config **file**.
Optionally, you can define custom delimeter between name and value.

## shell_config_get ##
Function searches for the **name** variable in the config **file**. Optionally, you
can define custom delimeter between name and value.

## shell_config_set ##
Function adds or uncomments **name** variable in the config **file**.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

