#!/bin/sh -efu

if [ -z "${__included_shell_error:-}" ]; then
__included_shell_error=1

PROG="${PROG:-${0##*/}}"

info() {
	printf %s\\n "$PROG: $*" >&2
}

fatal() {
	printf %s\\n "$PROG: $*" >&2
	exit 1
}

quiet=
verbose=
verbose() {
	[ -n "$verbose" ] || return 0
	info "$@"
}

show_usage() {
	[ -z "$*" ] || info "$*"
	echo "Try \`$PROG --help' for more information." >&2
	exit 1
}

fi
