cgrep(1)

# NAME

cgrep - a simple filter, you can use to colorize output of any program

# SYNOPSIS

- cgrep [options] PATTERN [--] [FILE...]
- cgrep [options] -e PATTERN [-e PATTERN1...] [--] [FILE...]

# DESCRIPTION

Pattern format:

PATTERN := ’/GREP-PATTERN/ [[TYPE] MODIFICATOR COLOR]...’

You can use any character instead of ’/’.

TYPE    := {foreground|background} or {fg|bg}

COLOR   := {gray|black|blue|green|cyan|red|magenta|yellow|white}

MODIFICATORS := {bold|italic|underline|reverse} or {b|i|u|rev}

# OPTIONS

*-e, --pattern=PATTERN*
	use PATTERN as the pattern;

*-f, --file=FILE*
	obtain patterns from FILE, one per line;

*-i, --ignore-case*
	ignore case distinctions in the PATTERN;

*-a, --all-lines*
	don’t suppress unmatched lines;

*-o, --one-match*
	highlight only first match of PATTERN;

*-E, --regexp-extended*
	use extended regular expressions in the PATTERN;

*-v, --verbose*
	print a message for each action;

*-V, --version*
	print program version and exit;

*-h, --help*
	show this text and exit.

# ENVIRONMENT

_COLOR_VIEWER_
	The name of the viewer.

# AUTHOR
Authors and contributors of the programs included in the *libshell* package are listed
in the COPYING file.

# BUGS
Report bugs to the authors.
