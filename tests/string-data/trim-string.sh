#!/bin/dash -efu
# SPDX-License-Identifier: GPL-2.0-or-later

. ../shell-var

pad=''
i=0
while [ "$i" -lt 20 ]; do
	pad="$pad "
	i=$((i + 1))
done

string="${pad}hello world${pad}"

i=0
while [ "$i" -lt 100000 ]; do
	shell_var_trim result "$string"
	i=$((i + 1))
done

times
