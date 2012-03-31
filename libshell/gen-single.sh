#!/bin/sh -efu

temp="$(mktemp "$0.XXXXXXXXX")"
"${0%/*}"/gen-deps.sh "$@" > "$temp"

srclist=" "
for src; do
	[ -f "$src" ] ||
		continue

	src="$(readlink -ev "$src" 2>/dev/null)"

	[ -z "${srclist##* $src *}" ] ||
		srclist="$srclist $src "
done

cat <<EOF
#!/bin/sh -efu
### This file is covered by the GNU General Public License,
### which should be included with libshell as the file LICENSE.
### All copyright information are listed in the COPYING.

if [ -z "${__included_shell_single-}" ]; then
__included_shell_single=1
EOF

list="$srclist"
while :; do
	nlist=
	for src in $list; do
		name="${src##*/}"

		if grep -qs "^$name[[:space:]]" "$temp"; then
			nlist="$nlist $src"
			continue
		fi

		printf '\n### %s\n' "$name"
		sed \
			-e '/^#!\/bin\/sh/d'        \
			-e 's/[[:space:]]*###.*$//' \
			-e '/^$/d'                  \
			-e '/^. shell-.*/d'         \
			-e '/__included_shell_/d'   \
			"$src"

		sed -i -e "/[[:space:]]$name\$/d" "$temp"
	done
	[ -n "$nlist" ] || break
	list="$nlist"
done
rm -f -- "$temp"

cat <<EOF
fi # __included_shell_single
EOF
