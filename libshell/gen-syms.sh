#!/bin/sh -efu

. ./shell-quote

for fn; do
	quote_sed_regexp_variable name "${fn##*/}"
	sed -n -e "s#^\\([A-Za-z][A-Za-z0-9_]\\+\\)().*#$name\t\\1#p" "$fn"
done |
	sort -u
