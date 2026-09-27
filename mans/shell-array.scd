shell-array(3)

# NAME
shell_array_append, shell_array_set, shell_array_get, shell_array_pop,
shell_array_unset - functions implementing arrays over plain shell variables.

# SYNOPSIS
- shell_array_append array value
- shell_array_set array value [index]
- shell_array_get array index variable
- shell_array_pop array [variable]
- shell_array_unset array [index]

# DESCRIPTION
POSIX shell has no array type. This library emulates one on plain
variables: an array named *array* is the element count variable *array*
plus the zero-based element variables *array0*, *array1*, and so on.
Elements are dense. They may hold arbitrary values, including spaces,
quotes, newlines and shell metasyntax.

The predicate functions (*exists*, *includes*, *find* and *equal*)
return 0 on success and 1 on failure. Usage errors - bad arguments,
invalid names or indices, and out-of-bounds access - are fatal.

## shell_array_append
Appends *value* to the end of the *array*.

Example:
```
shell_array_append colors red
shell_array_append colors "green green"
shell_array_join colors           # red green green
```

## shell_array_set
Stores *value* at *index* of the *array*. If the index is beyond the
current size, the array is grown and the skipped elements are empty.
Without an index the value is appended.

## shell_array_get
Stores the element at *index* in the caller's variable *variable*. An
empty element yields an empty string.

## shell_array_pop
Removes the last element of the *array*. With a second argument its
value is stored in the caller's variable *variable*.

## shell_array_unset
With one argument, destroys the *array*: all element variables and the
count variable are removed, the name can be reused afterwards. With a
second argument, removes the element at *index* and compacts the
elements that follow.

# NOTES
- Indices must be non-negative decimal integers without leading zeros.
- An array name must not be a prefix of another array name immediately
  followed by a digit (arrays *x* and *x1* would collide on the slot
  variable *x1*).
- Elements beyond the current size may linger in the variable space and
  are intentionally left there: the count variable alone defines the
  array, which keeps removal operations cheap.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
