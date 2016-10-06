% SHELL-TERMINFO
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

color_message, color_text, terminfo_col, terminfo_color_pattern, terminfo_init, terminfo_row -
functions to use terminal escape sequence to paint text or change cursor position

# SYNOPSIS #

- terminfo_init [force]
- terminfo_color_pattern (begin|end) pattern
- terminfo_col number
- terminfo_row number
- color_message text pattern
- color_text text pattern

# DESCRIPTION #
Collection of functions to use terminal escape sequence to paint text or change cursor position.
The functions don't aim to replace the `tput`. They were created to simplify the process of 
text colorization.

## color_text ##
The function prints the text and applies the specified by **pattern** escape sequence to it.
If the terminal type is unknown or if it's `dumb`, then the text will be printed without
the escape sequence.

## color_message ##
Same as **color_text**, but prints new line at the end of line.

## terminfo_init ##
Function initialize library. It determines the size of terminal, the supported escape sequences
and the order of colors. Usually this function executes only once, but you can force it
to reinitialize library.

## terminfo_color_pattern ##
Function returns the starting or ending escape sequence for the pattern.

## terminfo_col ##
Function moves cursor to the specified column.

## terminfo_row ##
Function moves cursor to the specified row.

# SYNTAX #
The *pattern* consists of human-readable keywords separated by spaces. Keywords are divided
into text modifiers and text highlighting.

Format: `[modificator] [[type] color]`

- **modificator** - how to modify the text. Valid values:
  **bold**(**b**), **italic**(**i**), **underline**(**u**), **reverse**(**rev**).
- **color** - the color to fill the text or background. Valid colors:
  **black**, **blue**, **green**, **cyan**, **red**, **magenta**, **yellow**, **white**
- **type** - determines how to apply the color: **foreground**(**fg**), **background**(**bg**).

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

