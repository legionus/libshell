#!/bin/sh -efu

if [ -z "${__included_shell_args:-}" ]; then
__included_shell_args=1

. shell-error.sh

opt_check_read() {
	local value
	value="$(readlink -ev "$2")" &&
		[ -r "$value" ] ||
		fatal "$1: $2: file not available."
	printf %s "$value"
}

opt_check_dir() {
	local value
	value="$(readlink -ev "$2")" &&
		[ -d "$value" -a -x "$value" ] ||
		fatal "$1: $2: directory not available."
	printf %s "$value"
}

opt_check_number() {
	printf '%d' "$2" >/dev/null 2>&1 ||
		[ "$2" -gt 0 ] 2>/dev/null ||
		fatal "$1: $2: invalid number."
	printf %s "$2"
}

fi
