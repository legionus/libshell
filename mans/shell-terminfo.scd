shell-terminfo(3)

# NAME
terminfo_init, terminfo_color_pattern, terminfo_col, terminfo_row,
color_text, color_message - functions that wrap `tput` to colour
output and move the cursor.

# SYNOPSIS
- terminfo_init [*force*]
- terminfo_color_pattern *begin|end* *pattern*
- terminfo_col *number*
- terminfo_row *number*
- color_text *text* [*pattern*]
- color_message *text* [*pattern*]

# DESCRIPTION

A small helper layer on top of `tput`. It probes which capabilities the
current terminal supports, assigns conventional numbers to the eight
basic colours, and exposes functions that build and print the correct
escape sequences. The functions do not replace `tput` and make no
guarantee about a given terminal; their only purpose is to remove the
guesswork of hand-coding escape sequences.

## terminfo_init
Initialises the module. It reads the screen size (using `tput cols`
and `tput lines`) into the `COLUMNS` and `LINES` variables, probes
for the required capabilities (foreground and background colour,
attribute resets, cursor addressing) and assigns the numbers 0 through
7 to the eight colour variables named *color_black* through
*color_white*.

It is normally run only once; pass *force* to re-probe the
capabilities. It returns a non-zero status when the `tput` utility, or
the `COLUMNS` and `LINES` values, cannot be determined.

## terminfo_color_pattern
Prints the opening or the closing escape sequence for *pattern*.
*begin* (or *b*) prints the opening sequence; *end* (or *e*) prints the
matching attribute reset. Any other value is an error.

The module must be initialised first: if *terminfo_init* (or
*color_text*) has not already run, the printed sequence is empty
because the capability names are still unset.

Example, on a terminal that supports colours:
```
terminfo_init
terminfo_color_pattern begin 'fg blue bold'   # opening sequence
terminfo_color_pattern end   'fg blue bold'   # closing sequence
```

## terminfo_col
Moves the cursor to the column *number*. If *number* is not less than
the value of `COLUMNS`, a message is printed and a non-zero status is
returned. If the `hpa` capability is not available on the current
terminal, the sequence is empty instead.

## terminfo_row
Moves the cursor to the row *number*. If the `vpa` capability is not
available on the current terminal, a message is printed and the
resulting sequence is empty.

## color_text
Ensure the module is initialised (it runs `terminfo_init` on first
use), then print the opening sequence for *pattern*, then *text*, then
the closing sequence. No trailing newline is printed. When no pattern
is given, or the terminal does not expose colour, *text* is printed as
is.

## color_message
Same as *color_text*, but a trailing newline is appended after the
text.

Example:
```
color_message 'warning' 'fg green bold'
# warning
```

# NOTES
A *pattern* is a space separated list of keywords, each chosen from:

- *foreground* or *fg* : colour is a foreground colour,
  (this is the default);
- *background* or *bg* : colour is a background colour;
- *bold* (*b*), *italic* (*i*), *underline* (*u*), *reverse* (*rev*)
  : text attributes;
- a colour name, one of *black*, *red*, *green*, *yellow*, *blue*,
  *magenta*, *cyan* or *white*.

A colour keyword is acted on only after the capability has been probed
successfully by `terminfo_init`; a keyword that is neither a
modifier, a colour kind nor a colour name is a fatal error.

The functions read the *pattern* argument positionally; `fg`/`bg` must
precede the colour keyword they apply to.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
