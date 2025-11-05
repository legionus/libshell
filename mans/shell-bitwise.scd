shell-bitwise(3)

# NAME

is_bit_set, clear_bit, clear_bits, get_bit, set_bit, set_bit_value,
set_bits, toggle_bit, toggle_bits, integer_to_binary - functions for obtaining,
setting, and clearing individual bits in a number.

# SYNOPSIS

- is_bit_set number bit_pos
- get_bit result_var number bit_pos
- set_bit_value result_var number bit value
- set_bit result_var number bit
- clear_bit result_var number bit
- toggle_bit result_var number bit
- integer_to_binary number max_bits

# DESCRIPTION

## is_bit_set

Checks whether the bit at position bit_pos is set.

Arguments:
- number     - integer value to extract the bit from
- bit_pos    - bit position (0 = least significant bit)

Result:
The return 0 (true) if bit is set, 1 (false) if not.

## get_bit

Extract the value of the specified bit from a number.

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to extract the bit from
- bit_pos    - bit position (0 = least significant bit)

Result:
The value of the specified bit (0 or 1) is stored in result_var.

## set_bit_value

Sets the specified bit in a number to a given value (0 or 1).

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to modify
- bit        - bit position (0 = least significant bit)
- value      - desired bit value (0 or 1)

Result:
The modified number with the updated bit is stored in result_var.

## set_bit

Sets the specified bit to 1.

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to modify
- bit        - bit position (0 = least significant bit)

Result:
The modified number with the bit set to 1 is stored in result_var.

## clear_bit

Clears (sets to 0) the specified bit.

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to modify
- bit        - bit position (0 = least significant bit)

Result:
The modified number with the bit cleared is stored in result_var.

## toggle_bit

Toggles (inverts) the specified bit.

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to modify
- bit        - bit position (0 = least significant bit)

Result:
The modified number with the bit inverted is stored in result_var.

## set_bits

Sets multiple bits to 1 in a number.

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to modify
- bit1...N   - list of bit positions to set

Result:
The modified number with all specified bits set to 1 is stored in result_var.

## clear_bits

Clears (sets to 0) multiple bits in a number.

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to modify
- bit1...N   - list of bit positions to clear

Result:
The modified number with all specified bits cleared is stored in result_var.

## toggle_bits

Toggles (inverts) multiple bits in a number.

Arguments:
- result_var - name of the variable to store the result
- number     - integer value to modify
- bit1...N   - list of bit positions to toggle

Result:
The modified number with all specified bits inverted is stored in result_var.

## integer_to_binary

Prints the number in bit representation.

Arguments:
- number   - integer value
- max_bits - specifies the bitness of the number

# AUTHOR
Authors and contributors of the programs included in the *libshell* package are listed
in the COPYING file.

# BUGS
Report bugs to the authors.

