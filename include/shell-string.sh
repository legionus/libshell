#!/bin/sh -efu

if [ -z "${__included_shell_string:-}" ]; then
__included_shell_string=1

# quote argument for sed regexp.
quote_sed_regexp() {
	local out="$*"
	if [ -z "${out##*[\[\].^\$\\/]*}" ]; then
		out="$(printf %s "$out" |sed -e 's/[].^$[\/]/\\&/g')" ||
			return 1
	fi
	printf %s "$out"
}

# quote argument for shell.
quote_shell() {
	local out="$*"
	if [ -z "${out##*[\"\$\`\\]*}" ]; then
		out="$(printf %s "$out" |sed -e 's/["$`\]/\\&/g')" ||
			return 1
	fi
	printf %s "$out"
}

fi
