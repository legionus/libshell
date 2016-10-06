% SHELL-SIGNAL
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

set_cleanup_handler, signal_handler, unset_cleanup_handler - functions to signal handling.

# SYNOPSIS #

- signal_handler (handler|SIG_IGN|SIG_DFL) signal [signal...]
- set_cleanup_handler handler
- unset_cleanup_handler

# DESCRIPTION #

## signal_handler ##
Function sets handler code whan any of the specified signals are received.
Return code of handler function will be ignored. Special handlers is
SIG_IGN and SIG_DFL (See ***signal (2)***).

Usage example:
```bash
signal_handler 'echo $arg' TERM EXIT HUP
signal_handler SIG_IGN     TERM EXIT HUP
signal_handler SIG_DFL     TERM EXIT HUP
```

## set_cleanup_handler ##
Function sets exit handler. The handler function takes the exit code as an argument.
Return code of handler function will be ignored.

Usage example:
```bash
exit_function() { echo "Exit with return code '$1'"; }
set_cleanup_handler exit_function
```

## unset_cleanup_handler ##
Function removes exit handler. Usage example:
```bash
unset_cleanup_handler
```

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

