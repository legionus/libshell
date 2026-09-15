shell-process(3)

# NAME
daemon, daemon_close_fd, daemon_write_pid - functions for running as a
background daemon and managing the pid file.

# SYNOPSIS
- daemon [*program* ...]
- daemon_close_fd *fd* ...
- daemon_write_pid *pidfile* [*force*]

# DESCRIPTION

## daemon
Detaches the calling process from its controlling terminal and runs it
in the background. A child is started (through `setsid` when available,
so the process also leaves its process group and session); the parent
exits with status 0, so any error is only seen by the child.

Once running the child closes any file descriptor other than the first
three (or only descriptors 3 through 9 when they cannot be enumerated),
optionally locks and writes a *pid file*, redirects standard input from
the null device and standard output and standard error to log files
(or the null device), ignores the HUP, INT and QUIT signals, changes
the working directory to the root directory and clears the umask.

On success *daemon* returns 0 and returns 1 if an error occurred
(typically because the pid file could not be locked or written).

The following variables may be set before the call to change the
behaviour: *daemon_noclose* keeps descriptors 3 and higher open;
*daemon_nokill* skips the check for an already-running instance and
always overwrites the pid file; *daemon_nolock* does not lock the pid
file; *daemon_err_file* and *daemon_log_file* name the files standard
errors and standard output are appended to (defaulting to the null
device); and *daemon_pid_file* names the pid file to manage.

Locking the pid file requires the `flock` utility, which is mandatory
when *daemon_pid_file* is set and *daemon_nolock* is unset.

## daemon_close_fd
Closes the file descriptors given as arguments. Descriptors are closed
one after another; descriptors 0, 1 and 2 should of course not be
passed here.

Example:
```
exec 3</dev/null
daemon_close_fd 3
```

## daemon_write_pid
Writes the current process id to *pidfile*, refusing to do so when the
pid recorded already belongs to a running process. *force* (any
non-empty value) disables the check and overwrites unconditionally.

When the file does not exist, is empty, or holds a pid that is not
live, the file is written. A non-zero status is returned only when an
existing live pid blocks the write.

Example:
```
daemon_pid=/tmp/mydaemon.pid
daemon_write_pid "$daemon_pid" &&
    cat "$daemon_pid"   # current process id
```

# NOTES
*daemon* relies on the shell being able to re-execute itself; it is
meant for POSIX shells. The pid written by *daemon_write_pid* is the
pid of the shell (`$$`), not of any external program launched later.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
