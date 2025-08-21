#!/bin/dash -efu
# SPDX-License-Identifier: GPL-2.0-or-later

. ../shell-string

__shell_string_foreach_prepare ctx "$string"
while __shell_string_foreach_continue "$ctx"; do
	__shell_string_foreach_char c "$ctx"
	__shell_string_foreach_iter "$ctx"
done
times
