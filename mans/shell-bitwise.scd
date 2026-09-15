shell-bitwise(3)

# NAME
is_bit_set, get_bit, set_bit_value, set_bit, clear_bit, toggle_bit,
set_bits, clear_bits, toggle_bits, integer_to_binary - functions for
examining, setting, clearing and toggling individual or groups of bits
in a shell integer.

# SYNOPSIS
- is_bit_set number bit_pos
- get_bit result_var number bit_pos
- set_bit_value result_var number bit_pos bit_value
- set_bit result_var number bit_pos
- clear_bit result_var number bit_pos
- toggle_bit result_var number bit_pos
- set_bits result_var number bit_pos...
- clear_bits result_var number bit_pos...
- toggle_bits result_var number bit_pos...
- integer_to_binary number [max_bits]

# DESCRIPTION

## is_bit_set
Checks whether bit *bit_pos* of *number* is set. Returns 0 when the
bit is set, non-zero otherwise.

Example:
```
is_bit_set 42 2 && echo "bit 2 set"
```

## get_bit
Stores the value of bit *bit_pos* of *number* (0 or 1) in the
variable named by *result_var*.

Example:
```
get_bit b 42 1; echo $b       # 1
get_bit b 42 2; echo $b       # 0
```

## set_bit_value
Copies *number* into the variable named by *result_var* after setting
bit *bit_pos* to the value *bit_value* (0 or 1).

Example:
```
set_bit_value v 0 3 1; echo $v    # 8
set_bit_value v 8 3 0; echo $v    # 0
```

## set_bit
Equivalent to *set_bit_value* with *bit_value* set to 1.

Example:
```
set_bit v 0 3; echo $v    # 8
```

## clear_bit
Equivalent to *set_bit_value* with *bit_value* set to 0.

Example:
```
clear_bit v 255 7; echo $v    # 127
```

## toggle_bit
Equivalent to *set_bit_value* with *bit_value* chosen to invert the
current value of *bit_pos* in *number*.

Example:
```
toggle_bit v 42 2; echo $v    # 46
toggle_bit v 46 2; echo $v    # 42
```

## set_bits
Sets every bit listed in *bit_pos*... to 1. Equivalent to a series
of *set_bit* calls.

Example:
```
set_bits v 0 1 3 5; echo $v    # 42
```

## clear_bits
Sets every bit listed in *bit_pos*... to 0. Equivalent to a series
of *clear_bit* calls.

Example:
```
clear_bits v 255 0 2 4 6; echo $v    # 42 (== 0x2a)
```

## toggle_bits
Inverts every bit listed in *bit_pos*.... Equivalent to a series of
*toggle_bit* calls.

Example:
```
toggle_bits v 42 0 1; echo $v    # 40
```

## integer_to_binary
Prints the value of *number* as a binary number with at least
*max_bits* digits, zero-padded from the left. When *max_bits* is
omitted, it defaults to 8.

Example:
```
integer_to_binary 42 8
integer_to_binary 42 32
integer_to_binary -42 32
integer_to_binary 255      # 8 bits by default
```

# NOTES
Bit positions are zero-based, the least significant bit is position 0.

All operations are performed with shell integer arithmetic, so values
wrap around the width of the shell's `intmax_t`. On a 64-bit shell,
bit positions up to 62 are meaningful (position 63 corresponds to
the sign-extended constant `9223372036854775808`). On a 32-bit
shell, positions up to 30 (or 31 for the sign-extended constant).

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
