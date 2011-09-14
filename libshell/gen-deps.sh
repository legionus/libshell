#!/bin/sh -efu

. ./shell-quote

SH="${SH:-sh}"

for file; do
	quote_sed_regexp_variable fn "$file"
	quote_sed_regexp_variable name "${file##*/}"

	$SH -nxc ". $file" 2>&1 >/dev/null |
		sed -n \
			-e "\#^+ . $fn\$#d" \
			-e "s#^+\\+ \\. \\(.*\\)\$#$name\\t\\1#p"
done |
	sort -u
