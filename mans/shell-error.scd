shell-error(3)

# NAME
message, fatal, verbose - functions to display error and verbose messages

# SYNOPSIS
- message "text"
- fatal "text"
- verbose "text"

# DESCRIPTION
Common functions to display error and verbose messages on stderr.

## message
Prints *"text"* on stderr, prefixed with the value of *PROG* and a
colon (for example, `mytool: text`). Returns 0.

The message format can be adjusted with the following global
variables:

*message_syslog* - when set, the message is sent to the system
log (see `logger(1)`) tagged with PROG instead of stderr.

*message_time* - when set, the current date is added as a prefix to
the message using `date(1)`.

*message_time_format* - date format used for *message_time*
(default `[%Y-%m-%d %T]`).

Example:
```
PROG=mytool
message "something went wrong"       # mytool: something went wrong

message_time=1
message "now"                        # [2026-09-14 12:00:00] mytool: now

message_syslog=1
message "to syslog"                  # sent to syslog
```

## fatal
Prints *"text"* on stderr (via *message*) and exits the current shell
with status 1. Any code after *fatal* in the same execution path is
not executed.

Example:
```
[ -w /nonexistent-dir ] || fatal "cannot write"
```

## verbose
Prints *"text"* on stderr only when verbose mode is enabled, i.e.
when the global variable *verbose* is non-empty. Returns 0 in both
cases. The variable *quiet* may be used by the calling program to
suppress its own output; *message* and *verbose* do not check it
themselves.

Example:
```
verbose=-v
verbose "starting"     # printed
verbose=
verbose "skipped"      # not printed
```

# NOTES
*PROG* is set by default to the command name (the basename of
the shell invocation) and may be overridden by the application
to control the message prefix and the syslog tag.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
