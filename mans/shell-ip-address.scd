shell-ip-address(3)

# NAME

ipv4_ip_subnet, ipv4_mask2prefix, ipv4_prefix2mask, ipv4_ptonx, ipv6_addr_type, ipv6_ip_matches, ipv6_ptonx, valid_ipv4 - functions to manipulate IP addresses

# SYNOPSIS

- ipv4_ip_subnet ipaddr subnet
- ipv4_mask2prefix value
- ipv4_prefix2mask value
- valid_ipv4 ipaddr
- ipv4_ptonx ipaddr

- ipv6_addr_type ipaddr
- ipv6_ip_matches ipaddr prefix
- ipv6_ptonx ipaddr

# DESCRIPTION

## ipv4_ip_subnet
Function checks that IPv4 address is in subnet.

Example:
```
ipv4_ip_subnet 172.16.1.2 172.16.1.0/24; echo res=$?
res=0

ipv4_ip_subnet 172.16.3.2 172.16.1.0/24; echo res=$?
res=1
```

## ipv4_mask2prefix
Function counts the leading 1 bits in the routing mask.

Example:
```
ipv4_mask2prefix 255.255.0.0
16

ipv4_prefix2mask 255.255.255.0
24
```

## ipv4_prefix2mask
Function converts routing prefix to netmask.

Example:
```
ipv4_prefix2mask 16
255.255.0.0

ipv4_prefix2mask 24
255.255.255.0
```

## ipv4_ptonx
This function interprets the given option value as an IPv4 address similarly to inet_pton(3), and outputs each octet in network byte order as 4 adjacent 2-digit hexadecimal numbers.
This form is useful to perform bitwise operations on the address.

Example:
```
ipv4_ptonx 192.0.0.2; echo res=$?
c0000002
res=0

ipv4_ptonx example.org; echo res=$?
res=1

ipv4_ptonx 377.0.0.1; echo res=$?
res=1

ipv4_ptonx 255.255.255.255; echo res=$?
ffffffff
res=0
```

*ipv4_ptonx* expects the entire string to represent an address, i. e. no trailing characters after the address.
Note that *ipv4_ptonx* makes no assumptions about the meaning of the address or the network environment; unlike *valid_ipv4*, it does not exclude special-use and multicast addresses, nor infer any special qualities based on a certain prefix length (e. g. last octet is not disallowed to be equal to 0 or 255).

## ipv6_addr_type
This function interprets the given option value as an IPv6 address similarly to inet_pton(3), and determines its type in regard to various special properties. If the input string is a well-formed IPv6 address, the function returns successfully, and its output value belongs to the following enum:
- *unspec*, the zero address;
- *loopback*, the *::1* address;
- *ipv4-mapped*, an address from *::ffff:0:0/96*;
- *link-local*, a link-local unicast address;
- *multicast*, an address from *ff00::/8*;
- *other*.

Example:
```
ipv6_addr_type 2001:db8:1:103a::2; echo res=$?
other
res=0

ipv6_addr_type example.org; echo res=$?
res=1

ipv6_addr_type ff02::1:0:a; echo res=$?
multicast
res=0

ipv6_addr_type ::ffff:25.25.25.25; echo res=$?
ipv4-mapped
res=0
```

Most IPv6 addresses fall into the *other* category. The value *other*, though, is designed to be a default match.
If an address falls into a different category, not *other*, we guarantee it will remain in that category, but new categories might or might not appear in the future that may cover some addresses that were previously *other*.
It is not recommended to test if an address is in the *other* category; instead, test for a different category, and fall back to different code otherwise.

Example:
```
for addr in $(get_ifaddrs "$iface"); do
	t="$(ipv6_addr_type "$addr")" ||
		continue
	case "$t" in
		ipv4-mapped|multicast)
			# Ignore.
			;;
		link-local)
			maybe_update "$addr%$iface"
			;;
		*)
			maybe_update "$addr"
			;;
	esac
done
# This code does not rely on $addr staying 'other'.
```

*ipv6_addr_type* expects the entire string to represent an address, i. e. no trailing characters after the address.

The intended purpose of *ipv6_addr_type* is to prevent misuse of special-use addresses.
For example, since link-local unicast addresses only make sense within a link and are incomplete without a scope identifier, it generally makes no sense to specify them in DNS AAAA records.

## ipv6_ip_matches
Checks that an IPv6 address is in a prefix (IOW, belongs in a range with common leading bits).

Example:
```
ipv6_ip_matches 3fff:e:b:1::2 3fff:e:b:1::/64; echo res=$?
res=0

ipv6_ip_matches 3fff:e:b:3::2 3fff:e:b:1::/64; echo res=$?
res=1

ipv6_ip_matches 3fff:e:b:3::2 3fff:e:b::/48; echo res=$?
res=0
```

Remember that an IPv6 prefix (netmask of leading 1 bits), unlike an IPv4 prefix, does not necessarily have routing significance; it might or might not be reachable "on-link" in any subnet.

## ipv6_ptonx
This function interprets the given option value as an IPv6 address similarly to inet_pton(3), and outputs each octet in network byte order as 16 adjacent 2-digit hexadecimal numbers.
This form is useful to perform bitwise operations on the address.

Example:
```
ipv6_ptonx 2001:db8:1:103a::2; echo res=$?
20010db80001103a0000000000000002
res=0

ipv6_ptonx 2001:db8:1:103a:6f:8d71:192.0.2.4; echo res=$?
20010db80001103a006f8d71c0000204
res=0

ipv6_ptonx example.org; echo res=$?
res=1

ipv6_ptonx 9:a; echo res=$?
res=1
```

*ipv6_ptonx* expects the entire string to represent an address, i. e. no trailing characters after the address.
Note that *ipv6_ptonx* only deals with a 128-bit network address; it knows nothing about scope identifiers (e. g. %eth0) or upper layer ports.

## valid_ipv4
Function checks that given option value is a valid IPv4 address.

# ENVIRONMENT

*regex_byte* - Regexp for single octet in an IPv4 address.

*regex_ipaddr* - Regexp for 4-byte address.

*regex_ipv4* - Regexp for IPv4 address (see <http://en.wikipedia.org/wiki/IP_address>). Some first-octet
values have special meanings:

- First octet 127 represents the local computer, regardless of what network it is really in.
  This is useful when testing internal operations.
- First octet 224 and above are reserved for special purposes such as multicasting.

Octets 0 and 255 are not acceptable values in some situations, but 0 can be used as the second
and/or third octet (e.g. 10.2.0.100).

# AUTHOR
Authors and contributors of the programs included in the *libshell* package are listed
in the COPYING file.

# BUGS
Report bugs to the authors.

