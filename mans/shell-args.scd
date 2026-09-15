shell-args(3)

# NAME
opt_check_read, opt_check_exec, opt_check_dir, opt_check_number,
show_usage, parse_common_option, show_help, print_version - functions
to check option type and to parse common options.

# SYNOPSIS
- opt_check_read "option-name" "option-value"
- opt_check_exec "option-name" "option-value"
- opt_check_dir "option-name" "option-value"
- opt_check_number "option-name" "option-value"
- show_usage ["error-message"]
- parse_common_option "option"

# DESCRIPTION
Common functions to validate option values, to print a short usage
message, and to parse the common *quiet*, *verbose*, *version* and
*help* options.

## opt_check_read
Validates that *option-value* is a readable regular file. On success,
prints the canonicalized file name (as `readlink -f` would) on stdout.
On failure, *option-name* and *option-value* are passed to *fatal*
and the program exits with status 1.

Example:
```
opt_check_read --input /nonexistent
# fatal: --input: /nonexistent: file not available.

opt_check_read --input /etc/hostname
# /etc/hostname
```

## opt_check_exec
Validates that *option-value* is a regular executable file. On
success, prints the canonicalized file name on stdout. On failure,
prints a message via *fatal* and the program exits with status 1.

Example:
```
opt_check_exec --tool /usr/bin/true
# /usr/bin/true

opt_check_exec --tool /etc/hostname
# fatal: --tool: /etc/hostname: file not executable.
```

## opt_check_dir
Validates that *option-value* is an existing directory that can be
traversed (both `-d` and `-x` are required). On success, prints the
canonicalized directory name on stdout. On failure, prints a message
via *fatal* and the program exits with status 1.

Example:
```
opt_check_dir --dir /tmp
# /tmp

opt_check_dir --dir /nonexistent/dir
# fatal: --dir: /nonexistent/dir: directory not available.
```

## opt_check_number
Validates that *option-value* is a positive decimal integer (that is,
a non-empty digit string with value greater than zero). On success,
prints the number on stdout. On failure, prints a message via *fatal*
and the program exits with status 1.

Example:
```
opt_check_number --count 42
# 42

opt_check_number --count 0        # zero is not accepted
# fatal: --count: 0: invalid number.

opt_check_number --count -1
# fatal: --count: -1: invalid number.
```

## show_usage
Prints an optional *error-message* (if given) via *message*, followed
by a hint to run *$PROG --help*, and exits the program with status 1.

Example:
```
show_usage "Unrecognized option: --x"
# myapp: Unrecognized option: --x
# Try `myapp --help' for more information.
```

## parse_common_option
Handles one of the common short- or long-form options: *help*,
*quiet*, *verbose* and *version*. On unrecognized options the program
is terminated via *fatal*.

The behavior of *help* and *version* is delegated to *show_help* and
*print_version*; the application must provide implementations of
both functions before calling *parse_common_option*.

Example:
```
show_help()    { echo "Usage: $PROG ..."; exit 0; }
print_version() { echo "$PROG 1.0"; exit 0; }
parse_common_option --help
# Usage: myapp ...
```

## show_help
Stub function that is expected to print the long-form usage of the
program and to terminate the shell. It is called by
*parse_common_option* on request of the *help* option. The default
implementation in *libshell* reports an error and exits.

## print_version
Stub function that is expected to print the version of the program and
to terminate the shell. It is called by *parse_common_option* on
request of the *version* option. The default implementation in
*libshell* reports an error and exits.

# ENVIRONMENT
*getopt_common_opts* - a read-only string of short *getopt(1)*
options that *parse_common_option* handles. The value is *q, v, V, h*.

*getopt_common_longopts* - a read-only string of long *getopt(1)*
options that *parse_common_option* handles. The value is
*quiet, verbose, version, help*.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
