#!/bin/dash -efu
# SPDX-License-Identifier: GPL-2.0-or-later

. ../shell-string

__shell_string_foreach_prepare string
while __shell_string_foreach_continue string; do
	__shell_string_foreach_char c string
	__shell_string_foreach_iter string
done
times
