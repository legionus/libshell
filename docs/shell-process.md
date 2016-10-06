% SHELL-PROCESS
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

daemon, daemon_close_fd, daemon_write_pid

# SYNOPSIS #

- daemon [program args]
- daemon_close_fd [fd0 fd1 ...]
- daemon_write_pid /path/to/pidfile [force]

# DESCRIPTION #

## daemon ##
Function helps programs wishing to detach themselves from the controlling terminal and run
in the background as system daemons.

This function forks and if the fork(2) succeeds, the parent
calls "exit 0", so that further errors are seen by the child only.

On success daemon() returns 0 or 1 if an error occurred.

Variables:

**daemon_noclose**  - do not close first 3-9 descriptors;

**daemon_nokill**   - do not check previous pid;

**daemon_nolock**   - do not lock the pid file;

**daemon_err_file** - specifies error log file (default /dev/null);

**daemon_log_file** - specifies log file (default /dev/null);

**daemon_pid_file** - specifies pid file.

## daemon_close_fd ##
Function closes all open descriptors or the selected one.

## daemon_write_pid ##
Function checks the PID from a pidfile and writes a new one.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

