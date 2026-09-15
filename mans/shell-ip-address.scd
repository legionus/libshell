shell-ip-address(3)

# NAME
valid_ipv4, ipv4_ip_subnet, ipv4_mask2prefix, ipv4_prefix2mask,
ipv4_ptonx, ipv6_ptonx, ipv6_ip_matches, ipv6_addr_type - functions
to validate, convert and classify IPv4 and IPv6 addresses.

# SYNOPSIS
- valid_ipv4 ipaddr
- ipv4_ip_subnet ipaddr subnet
- ipv4_mask2prefix netmask
- ipv4_prefix2mask prefixlen
- ipv4_ptonx ipaddr
- ipv6_ptonx ipaddr
- ipv6_ip_matches ipaddr prefix
- ipv6_addr_type ipaddr

# DESCRIPTION
Helpers for working with IPv4 and IPv6 addresses. The *valid_ipv4*,
*ipv4_ip_subnet*, *ipv6_ip_matches* and *ipv6_addr_type* functions use
the return status to signal success or a negative answer. The
*ipv4_mask2prefix*, *ipv4_prefix2mask*, *ipv4_ptonx* and
*ipv6_ptonx* functions print their result on standard output.

All of these functions expect the argument to be a plain address
string: no surrounding whitespace, no scope identifier, no protocol
or port suffix.

## valid_ipv4
Returns 0 when *ipaddr* is a usable host IPv4 address, non-zero
otherwise. The check is stricter than *ipv4_ptonx*: it rejects the
loopback range (*127/8*), multicast and reserved first octets
(224 and above), and refuses addresses whose last octet is 0 or 255
(network and broadcast addresses).

Example:
```
valid_ipv4 10.0.0.100 && echo address OK
# 10.0.0.100 OK

valid_ipv4 10.0.0.255 && echo network OK || echo network
# network

valid_ipv4 10.0.0.0    && echo addr OK    || echo addr rejected
# addr rejected
```

## ipv4_ip_subnet
Returns 0 if *ipaddr* belongs to the IPv4 network *subnet*
(written `address/prefixlen`), non-zero otherwise. Returns 2 when the
argument cannot be interpreted as an IPv4 address.

Example:
```
ipv4_ip_subnet 172.16.1.2 172.16.1.0/24 && echo in || echo out
# in

ipv4_ip_subnet 172.16.3.2 172.16.1.0/24 && echo in || echo out
# out
```

## ipv4_mask2prefix
Prints the length of the routing prefix, that is, the number of
leading 1 bits, of the IPv4 netmask *netmask*.

Example:
```
ipv4_mask2prefix 255.255.0.0    # 16
ipv4_mask2prefix 255.255.255.0  # 24
```

## ipv4_prefix2mask
Prints the dotted-quad netmask corresponding to a *prefixlen* between
0 and 32.

Example:
```
ipv4_prefix2mask 16    # 255.255.0.0
ipv4_prefix2mask 24    # 255.255.255.0
```

## ipv4_ptonx
Interprets *ipaddr* the same way as *inet_pton(3)* and prints each
of the four octets as two hexadecimal digits in network byte order,
for a total of eight digits. This representation is convenient for
bitwise arithmetic on the address.

Example:
```
ipv4_ptonx 192.0.0.2        # c0000002
ipv4_ptonx 255.255.255.255  # ffffffff
```

Unlike *valid_ipv4*, *ipv4_ptonx* accepts the broadcast and network
addresses as well as loopback and multicast space; it only checks that
the four octets are in range.

## ipv6_ptonx
Interprets *ipaddr* as an IPv6 address and prints it as thirty-two
lowercase hexadecimal digits (network byte order, with the implicit
zero groups expanded). This is the same compact form used by
*ipv6_ip_matches* and *ipv6_addr_type* and is convenient for bitwise
operations.

Example:
```
ipv6_ptonx 2001:db8:1:103a::2
# 20010db80001103a0000000000000002

ipv6_ptonx 2001:db8:1:103a:6f:8d71:192.0.2.4
# 20010db80001103a006f8d71c0000204
```

## ipv6_ip_matches
Returns 0 if *ipaddr* matches the IPv6 prefix *prefix*, which is
written in the form address/prefixlen; otherwise it returns non-zero.
A zero-length prefix matches any address.

Example:
```
ipv6_ip_matches 3fff:e:b:1::2 3fff:e:b:1::/64 && echo yes || echo no
# yes

ipv6_ip_matches 3fff:e:b:3::2 3fff:e:b:1::/64 && echo yes || echo no
# no

ipv6_ip_matches 3fff:e:b:3::2 3fff:e:b::/48  && echo yes || echo no
# yes
```

## ipv6_addr_type
Interprets *ipaddr* as an IPv6 address and prints a classification of
which class the address belongs to. The possible classifications are
*unspec*, the zero address; *loopback*, the address `::1`;
*ipv4-mapped*, an address from the IPv4-mapped range `::ffff:0:0/96`;
*link-local*, a link-local unicast address; *multicast*, an address
from `ff00::/8`; and *other*, any non-special address.

Example:
```
ipv6_addr_type ::1               # loopback
ipv6_addr_type 2001:db8::1      # other
ipv6_addr_type fe80::1          # link-local
ipv6_addr_type ff02::1:a        # multicast
ipv6_addr_type ::ffff:25.25.25.25   # ipv4-mapped
```

It is not recommended to compare the result with *other* in
production code: it is the default bucket for addresses that do not
match the special classes above, so any address could move out of it
without warning.

# NOTES
These helpers are intended for shell scripts that need to make simple
decisions about addresses. For more advanced uses (routing, DNS
resolution, address families other than IPv4/IPv6 ...) consult the
system's *getaddrinfo(3)* and related interfaces.

# ENVIRONMENT
The following read-only variables are defined when
*shell-ip-address* is loaded:

- *regex_byte*: a regular expression for a single IPv4 octet.
- *regex_ipaddr*: a regular expression for a dotted-quad IPv4 address.
- *regex_ipv4*: a stricter regular expression for an IPv4 address,
  used to reject loopback and multicast first octets.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
