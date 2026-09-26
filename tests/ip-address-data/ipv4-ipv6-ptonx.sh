#!/bin/dash -efu
# SPDX-License-Identifier: GPL-2.0-or-later

. ../shell-ip-address

i=0
while [ "$i" -lt 5000 ]; do
	ipv4_ptonx "203.0.113.1" >/dev/null
	ipv6_ptonx "2001:db8:1:103a::2" >/dev/null
	i=$((i + 1))
done

times
