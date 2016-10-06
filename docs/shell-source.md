% SHELL-SOURCE
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

source_if_executable, source_if_exists, source_if_notempty - functions to source
(include in runtime) another scripts with some conditions

# SYNOPSIS #

- source_if_executable file arg1 arg2
- source_if_exists file arg1 arg2
- source_if_notempty file arg1 arg2

# DESCRIPTION #

## source_if_executable ##
Function executes commands from file in the current environment if file is executable.

## source_if_exists ##
Function executes commands from file in the current environment if file exists.

## source_if_notempty ##
Function executes commands from file in the current environment if file is not empty.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

