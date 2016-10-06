% SHELL-IP-ADDRESS
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

ipv4_ip_subnet, ipv4_mask2prefix, ipv4_prefix2mask, valid_ipv4 - functions to validate the IPv4 address

# SYNOPSIS #

- ipv4_ip_subnet ipaddr subnet
- ipv4_mask2prefix value
- ipv4_prefix2mask value
- valid_ipv4 ipaddr

# DESCRIPTION #

## ipv4_ip_subnet ##
Function checks that IP address is in subnet.

Example:
```bash
ipv4_ip_subnet 172.16.1.2 172.16.1.0/24; echo res=$?
res=0

ipv4_ip_subnet 172.16.3.2 172.16.1.0/24; echo res=$?
res=1
```

## ipv4_mask2prefix ##
Function counts the leading 1 bits in the routing mask.

Example:
```bash
ipv4_mask2prefix 255.255.0.0
16

ipv4_prefix2mask 255.255.255.0
24
```

## ipv4_prefix2mask ##
Function converts routing prefix to netmask.

Example:
```bash
ipv4_prefix2mask 16
255.255.0.0

ipv4_prefix2mask 24
255.255.255.0
```

## valid_ipv4 ##
Function checks that given option value is a valid IPv4 address.

# ENVIRONMENT #

**regex_byte** - Regexp for single octet in an IPv4 address.

**regex_ipaddr** - Regexp for 4-byte address.

**regex_ipv4** - Regexp for IPv4 [address](http://en.wikipedia.org/wiki/IP_address). Some first-octet
values have special meanings:

- First octet 127 represents the local computer, regardless of what network it is really in.
  This is useful when testing internal operations.
- First octet 224 and above are reserved for special purposes such as multicasting.

Octets 0 and 255 are not acceptable values in some situations, but 0 can be used as the second
and/or third octet (e.g. 10.2.0.100).

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

