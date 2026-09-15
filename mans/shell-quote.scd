shell-quote(3)

# NAME
quote_sed_regexp, quote_sed_regexp_variable, quote_grep_regexp,
quote_grep_regexp_variable, quote_shell, quote_shell_variable,
quote_shell_args, string_quote_remove - functions to safely quote
values for regular expressions and for the shell.

# SYNOPSIS
- quote_sed_regexp *string*
- quote_sed_regexp_variable *retvar* *string*
- quote_grep_regexp *string*
- quote_grep_regexp_variable *retvar* *string*
- quote_shell *string*
- quote_shell_variable *retvar* *string*
- quote_shell_args *retvar* *string*
- string_quote_remove *string*

# DESCRIPTION
This set of helpers takes a value that contains arbitrary, possibly
special, characters and returns a form of it that can be safely placed
inside a regular expression for *sed* or *grep*, or evaluated by the
shell. Each function exists in a variant that prints the result
(*quote_*_regexp, *quote_shell*) and a variant that stores the result
in a named shell variable (*quote_*_regexp_variable,
*quote_shell_variable*).

## quote_sed_regexp
Escapes the characters that have special meaning in a *sed* basic
regular expression (BRE) so that *string* matches only itself. The
result is printed to standard output.

Example:
```
printf 'a*b\nab\n'   |
    sed "s/$(quote_sed_regexp 'a*b')/HIT/g"
# HIT
# ab
```

## quote_sed_regexp_variable
Does the same escaping as *quote_sed_regexp* but stores the result in
the variable *retvar* instead of printing it; *string* is the value to
evaluate.

This is most useful when both the pattern and the replacement hold
special characters:
```
# Pattern: unescaped "a*b" is "zero or more a, then b"; the quoted
# form matches only the literal string "a*b".
quote_sed_regexp_variable pat 'a*b'
printf 'aab\na*b\n' | sed "s/^$pat$/HIT/g"
# aab    (not matched: the * no longer means "zero or more")
# HIT    (a*b)

# Replacement: "&" would mean "the whole match" in a sed
# replacement, so it is escaped to stay literal.
quote_sed_regexp_variable rep '100 & $x'
printf 'old\n' | sed "s/^old$/NEW: $rep/"
# NEW: 100 & $x
```

## quote_grep_regexp
Escapes the characters with special meaning in a *grep* basic regular
expression for *string*, so the search matches the value literally,
and prints the result.

## quote_grep_regexp_variable
As *quote_grep_regexp*, but writes the escaped value into *retvar*.

## quote_shell
Escapes the shell metacharacters in *string* (double quote, backtick,
dollar sign, backslash) so that the value can be re-quoted by the shell
without the metacharacters gaining new meaning, and prints the result.

## quote_shell_variable
As *quote_shell*, but writes the escaped value into *retvar*.

A round-trip that shows the effect:
```
value='a"b $x `cmd` c\d'
quote_shell_variable qv "$value"
# qv is:  a\"b \$x \`cmd\` c\\d
eval "restored=\"$qv\""
[ "$restored" = "$value" ] && echo "round trip OK"
# round trip OK
```

## quote_shell_args
Takes *string* (the value to evaluate, passed as *retvar* is unused)
and returns a fully shell-quoted sequence of words so that, when
evaluated, the original list of words is preserved exactly. The result
is stored in *retvar*.

It quotes every non-alphanumeric character, and toggles between double
quote and single quote modes as needed. An unmatched quote in the input
causes the function to print an error and return a non-zero status.

Example, reconstructing a command line:
```
words='foo bar with  spaces'
quote_shell_args q "$words"
eval "set -- $q"
echo "number of words after eval: $#"
# number of words after eval: 4
```

## string_quote_remove
Obsolescent compatibility function. Strips a single leading and a
single trailing single quote or double quote from *string* if both are
present, and prints the remainder. This behaviour is brittle and the
function should not be relied on; it is provided only for compatibility
with scripts that set `__export_compatibility_string_quote_remove`
before loading the module.

Example:
```
__export_compatibility_string_quote_remove=1
string_quote_remove "'value'"   # -> value
string_quote_remove '"value"'   # -> value
string_quote_remove 'value'     # -> value
```

# NOTES
The *grep* and *sed* variants escape for basic regular expressions
(BRE). For extended regular expressions the set of special characters
differs and these functions do not help.

*quote_shell_args* operates on a single string argument and is intended
to be combined with `eval set --`. It is not the same as `xargs -n0`.

The compatibility function *string_quote_remove* is exported only when the compatibility flag
__export_compatibility_string_quote_remove is set before the module is
loaded.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
