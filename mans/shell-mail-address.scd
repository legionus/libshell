shell-mail-address(3)

# NAME
valid_email - function for simple e-mail address validation.

# SYNOPSIS
- valid_email *address*

# DESCRIPTION

## valid_email
Checks that *address* looks like an ordinary e-mail address: a local
part made of letters, digits, dots, hyphens and underscores, followed
by an at sign and a dot-separated domain that ends in a top-level
domain. Returns 0 when the address matches and 1 otherwise. The
comparison is case-insensitive.

Example:
```
valid_email 'john.doe@example.com' && echo OK || echo NO
# OK
valid_email 'no-at-sign' && echo OK || echo NO
# NO
```

# NOTES
The check is deliberately simple. It does not verify that the domain
resolves or that the mailbox exists, and it accepts some strings that
a full RFC 5322 validator would reject and rejects others it could
have accepted.

When `shell_mail_address_strict` is set before sourcing the module,
the top-level domain list is restricted to known generic and country
code top-level domains; otherwise a domain is accepted if its last
label is a two to four letter word.

The regular expression `regex_email` is exposed for parsing the
address. With `sed -E` capture group 1 is the local part and capture
group 3 is the domain. Because it relies on that expression, quoting
for a given *address* that is known to be valid is safe:
```
address='first.last@sub.domain.co'
local_part="$(printf '%s' "$address" |
             sed -E -e "s/^$regex_email\$/\1/i")"
domain="$(printf '%s' "$address" |
          sed -E -e "s/^$regex_email\$/\3/i")"
# local_part = first.last
# domain     = sub.domain.co
```

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
