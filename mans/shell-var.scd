shell-var(3)

# NAME
shell_var_trim, shell_var_unquote, shell_var_is_yes, shell_var_is_no,
shell_var_is_number - functions for operating on shell variables.

# SYNOPSIS
- shell_var_trim varname value
- shell_var_unquote varname value
- shell_var_is_yes value
- shell_var_is_no value
- shell_var_is_number value

# DESCRIPTION
Helpers for manipulating and validating shell variable values. The
*predicate* functions (*is_yes*, *is_no* and *is_number*) return 0
when the value matches and 1 when it does not. The *modifier*
functions (*trim* and *unquote*) take the name of a shell variable as
*varname* and store the result there.

## shell_var_trim
Strips leading and trailing whitespace (spaces, tabs and newlines)
from *value* and assigns the result to the variable named by
*varname*. Internal whitespace in the value is preserved.

Example:
```
shell_var_trim retval "   aaa bb  aaa "
echo "[$retval]"            # [aaa bb  aaa]
```

## shell_var_unquote
Removes one matching pair of quotes (either 'single' or "double")
from *value* and assigns the result to the variable named by
*varname*. Values that are not fully quoted, or whose quotes do not
match at both ends, are passed through unchanged.

Example:
```
for i in "\"str1\"" "'str2'" "\"str3'" plain; do
    shell_var_unquote var "$i"
    echo "[$var]"
done
# [str1]
# [str2]
# ["str3']
# [plain]
```

## shell_var_is_yes
Returns 0 when *value* matches one of the affirmative forms: *yes*,
*true*, *on*, *y*, *1* (case-insensitive). Returns 1 otherwise.

## shell_var_is_no
Returns 0 when *value* matches one of the negative forms: *no*,
*false*, *off*, *n*, *0* (case-insensitive). Returns 1 otherwise.

## shell_var_is_number
Returns 0 when *value* is a positive integer with no other
characters. Returns 1 for zero, negative numbers and any non-numeric
input.

Example:
```
shell_var_is_number 123  && echo OK || echo NOP   # OK
shell_var_is_number 420  && echo OK || echo NOP   # OK
shell_var_is_number a42  && echo OK || echo NOP   # NOP
shell_var_is_number '2 0' && echo OK || echo NOP  # NOP
```

# NOTES
*shell_var_is_yes* and *shell_var_is_no* are meant to be used as a
pair; they do not cross-match (for example, *is_yes* returns 1 for
*no* and *is_no* returns 1 for *yes*).

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
