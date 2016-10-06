% SHELL-ARGS
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #
opt_check_read, opt_check_exec, opt_check_dir, opt_check_number, show_usage, parse_common_option - functions
to check type of argument

# SYNOPSIS #

- opt_check_read "option-name" "option-value"
- opt_check_exec "option-name" "option-value"
- opt_check_dir "option-name" "option-value"
- opt_check_number "option-name" "option-value"
- show_usage ["error-message"]
- parse_common_option "option"

# DESCRIPTION #

## opt_check_read ##
Checks that given option value is a readable file.
Arguments: **option-name** is option name, **option-value** is option value.
If **option-value** is a readable file, outputs canonicalized file name, otherwise fails.

## opt_check_exec ##
Checks that given option value is an executable file.
Arguments: **option-name** is option name, **option-value** is option value.
If **option-value** is a executable file, outputs canonicalized file name, otherwise fails.

## opt_check_dir ##
Checks that given option value is a traversable directory.
Arguments: **option-name** is option name, **option-value** is option value.

## opt_check_number ##
Checks that given option value is a positive decimal integer.
Arguments: **option-name** is option name, **option-value** is option value.
If **option-value** is a positive decimal number, outputs it, otherwise returns fails.

## show_usage ##
Function shows short usage messages for script and finishes current script. Optionally,
this function can display error message.

## parse_common_option ##
Function to parse common arguments (*quiet*, *verbose*, *version*, *help*). Using this
function requires the definition of additional functions: **show_help**, **show_version**.

# ENVIRONMENT #

**getopt_common_opts**     - short (one-character) ***getopt (1)*** options to parse common arguments ("q,v,V,h").

**getopt_common_longopts** - long (multi-character) ***getopt (1)*** options to parse common arguments ("quiet,verbose,version,help").

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

