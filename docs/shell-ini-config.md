% SHELL-INI-CONFIG
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

ini_config_comment, ini_config_del, ini_config_get, ini_config_is_set,
ini_config_set - functions to work with a ini-like config files.

# SYNOPSIS #

- ini_config_comment file section [var]
- ini_config_del file section [var]
- ini_config_get file section var
- ini_config_is_set file section var
- ini_config_set file section var value

# DESCRIPTION #

## ini_config_comment ##
Function comments **var** variable in a specific **section** or the entire **section** as a whole.

## ini_config_del ##
Function removes variable from config **file**.

## ini_config_get ##
Function outputs **var** variable in a specific **section** from config **file**.

## ini_config_is_set ##
Function outputs nothing. It only checks that **var** variable exists in a specific **section**.
Returns 0 if variable was found, otherwise returns 1.

## ini_config_set ##
Function modifies or adds a variable in the **section**. If this **section** doesn't exist,
it will be created.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

