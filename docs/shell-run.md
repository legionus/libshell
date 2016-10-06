% SHELL-RUN
% 3
% October 2016
% libshell
% Linux Programmer's Manual


# NAME #

run_if_executable, run_scripts - functions to run external scripts.

# SYNOPSIS #

- run_if_executable file arg1 arg2
- run_scripts dir [args]

# DESCRIPTION #

## run_if_executable ##
Function executes command if file is executable.

## run_scripts ##
Function runs scripts from directory.

**RUN_SCRIPTS_EXCLUDE** - The list of patterns of files that must be ignored (default: '*.rpm* *.swp *,v *~ *.\#')

**SCRIPT_ERROR_FATAL** - Determines whether to stop if one of the scripts ended with error (default: false)

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

