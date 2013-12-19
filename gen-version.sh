#!/bin/sh -efu

. ${0%/*}/shell-version

printf '%s.%s.%s\n' "$libshell_vmajor" "$libshell_vminor" "$libshell_vpatch"
