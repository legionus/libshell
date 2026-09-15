shell-signal(3)

# NAME
signal_handler, set_cleanup_handler, unset_cleanup_handler - functions
for signal handling.

# SYNOPSIS
- signal_handler (handler|SIG_IGN|SIG_DFL) signal [signal...]
- set_cleanup_handler handler
- unset_cleanup_handler

# DESCRIPTION
Portable wrappers for the POSIX special *trap* command that let
several handlers be attached to the same signal. The handlers are
executed in the order in which they were registered.

## signal_handler
Registers *handler* to run when any of the listed *signal*s occurs.
*handler* is a shell command string, evaluated by the shell at the
moment the signal is delivered. The exit status of the handler is
ignored, so that all registered handlers for the same signal are
reached in sequence.

Use the special values *SIG_IGN* to reset the signal list (remove all
previously registered handlers and make the shell ignore the signal),
or *SIG_DFL* to restore the interpreter default disposition of the
signal.

Example:
```
signal_handler 'echo "exited with rc=$?"' EXIT
echo normal
exit 42
# normal
# exited with rc=42
```

When *handler* is written inside a double-quoted shell string, the
shell expands the expansion operators (for example the *$?* operator)
at the moment of registration, which fixes the value seen by the
handler. To capture the exit status at signal delivery time, keep the
expansion operator quoted in the string passed to *signal_handler*.

## set_cleanup_handler
Registers *handler* as a *cleanup* handler to run when the shell exits
via the *EXIT* trap, or when it is killed by one of the signals
*HUP*, *INT*, *PIPE*, *QUIT* or *TERM* for which *trap* is otherwise
unset. The command is invoked with the resulting exit (or error)
status of the shell as its first argument.

*handler* may be the name of a shell function. The cleanup handler
runs before the interpreter exits; its return value is ignored, and
the final exit status of the shell is not changed by the handler.

Example:
```
cleanup() { echo "cleanup called with rc=$1"; }
set_cleanup_handler cleanup
echo normal
exit 42
# cleanup called with rc=42
```

## unset_cleanup_handler
Removes the handler registered with *set_cleanup_handler*. All the
traps used by *set_cleanup_handler* are reset to the default
disposition, and the handler name is forgotten.

Example:
```
set_cleanup_handler 'echo cleanup'
unset_cleanup_handler
exit 0
# (no cleanup output on exit)
```

# NOTES
*libshell* implements multiple-handler support by chaining *trap*
commands; each registered handler sees, in turn, the exit status of
the shell and of the previously registered handler.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
