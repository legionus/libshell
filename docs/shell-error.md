% SHELL-ERROR
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #
message, fatal, verbose - functions to display error and verbose messages

# SYNOPSIS #
- message "text"
- verbose "text"
- fatal "text"

# DESCRIPTION #
Common functions to display debug, error and fatal messages.

## message ##
Function shows **"text"** on stderr. Use the following global variables
to change the message format or to use the syslog:

**message_syslog** - message will be sent to syslog using `logger(1)` if set.

**message_time** - date will be added as a prefix to the message using `date(1)`.

**message_time_format** - date format for *message_time* (default `[%Y-%m-%d %T]`).

## verbose ##
Function shows **"text"** on stderr if verbose-mode enabled. On the behavior
of the functions affected by the following global variables:

**verbose** - variable sets verbose mode.

## fatal ##
Function shows **"text"** on stderr and finishes execution of current script.

# ENVIRONMENT #

**PROG** - name of current script.

**quiet** - sets quiet mode for script.

**verbose** - sets verbose mode for script. It's assumed that in this mode the script
will show more debug messages.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.
