shell-json(3)

# NAME
json_foreach, json_foreach_handler, json_get_last_name,
json_get_full_name - functions for streaming JSON parsing.

# SYNOPSIS
- json_foreach
- json_foreach_handler type value
- json_get_last_name retvar
- json_get_full_name retvar [separator]

# DESCRIPTION
A small streaming JSON reader. *json_foreach* reads one JSON document
from standard input and walks over it; for every scalar value it
meets (string, number, boolean and null) it calls *json_foreach_handler*.
Objects and arrays are transparent; the position of the current value
is tracked as a stack of field names and can be queried with
*json_get_last_name* and *json_get_full_name*.

## json_foreach
Consumes standard input and parses the JSON document contained in
it. The parse is character-wise and streaming: no temporary file is
created and the document does not have to fit in memory. When the
handler returns the special status *JSON_FOREACH_ABORT* (100) the
walk stops and *json_foreach* returns 0.

The function exits with a non-zero status (via *shell-error* *fatal*)
when the input is not a valid JSON document.

Example:
```
echo '{"a":1,"b":{"c":"x"}}' | json_foreach
# /a number 1
# /b/c string x
```

## json_foreach_handler
Default callback, invoked as *json_foreach_handler type value* for
every scalar. *type* is one of *string*, *number*, *boolean* or
*null*; *value* is the text of the value (booleans are printed as
*true*/*false*, null as *null*). The default implementation prints the
name path, the type and the value separated by single spaces.

The handler may be overridden by the caller, e.g.:
```
json_foreach_handler()
{
    case "$1" in
        number) echo "NUM $2" ;;
    esac
}
echo '{"n":42,"s":"hi"}' | json_foreach
# NUM 42
```

## json_get_last_name
Stores the name of the last component of the current position (the
enclosing object key, or the array index) into *retvar*. It is
intended to be called from *json_foreach_handler*.

## json_get_full_name
Stores the path of the current position into *retvar*. The path is
the chain of object keys and array indices leading to the current
value, joined by *separator* (default `/`) and prefixed by it, so the
result always begins with a separator: an element at top-level
index 0 is reported as `/0`, an entry nested as `a.b` as `/a/b`.

Example:
```
json_foreach_handler()
{
    local f
    json_get_full_name f
    echo "${f:-/} <- $2"
}
echo '{"a":{"b":[10,20]},"x":true}' | json_foreach
# /a/b/0 <- 10
# /a/b/1 <- 20
# /x <- true
```

# NOTES
Only values of the four scalar types are handed to the handler; the
structural braces and brackets themselves are not reported. Nested
containers are walked in document order.

The special status *JSON_FOREACH_ABORT* has the value 100 and can be
referenced by name; returning any other non-zero status does not
abort the walk.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
