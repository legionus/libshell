shell-getopt(3)

# NAME
getopt, getoptex, getopts, getsubopt - functions to parse command
line options.

# SYNOPSIS
- getopt [options] [--] optstring parameters
- getopt optstring parameters
- getopt [options] -o|--options optstring [options] [--] parameters
- getopts optstring parameters
- getoptex optstring parameters
- getsubopt subopt-string

# DESCRIPTION
A portable, shell-only implementation of *getopt(1)*, *getopts(1)*,
*getsubopt(3)*, and of an extended option parser *getoptex* that adds
long-option support to *getopts*.

## getopt
A shell implementation of the *getopt(1)* utility (`util-linux`).
It parses *parameters* against *optstring*, performs option
permutation, and prints the resulting canonicalized command line on
stdout so that it can be *eval*ed by the calling
shell.

*getopt* supports most of the options accepted by *getopt(1)*:
*alternative*, *longoptions*, *name*, *options*, *quiet*,
*quiet-output*, *shell*, *unquoted*, *version*, and *help* (see
*getopt(1)* for the exact spelling and behavior of each option).

Example:
```
TEMP=$(getopt -n "$PROG" -o "v:,V,h" -l "verbose:,version,help" -- "$@") ||
	show_usage
eval set -- "$TEMP"

while :; do
	case "$1" in
		-h|--help) show_help ;;
		-v|--verbose) shift; verbose="$1" ;;
		-V|--version) print_version "$PROG" ;;
		*) fatal "Unrecognized option: $1" ;;
	esac
	shift
done
```

## getsubopt
Parses comma-separated sub-options in a single string. This is a
shell implementation of *getsubopt(3)*.

*subopt-string* is a string that names the recognized options and
indicates which of them require a value, using a trailing `:` for
each option that takes an argument.

On each iteration the function sets *OPTOPT* to the option name that
was recognized and *OPTARG* to the value that followed the `=`
separator (empty when none was given).

Example:
```
while getsubopt 'rw mode: path: dev:' 'rw,mode=755,path=/zzz,dev=/dev/zzz'; do
	echo "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
done
```

When run, the loop prints:
```
Option <rw> 
Option <mode> has an arg <755>
Option <path> has an arg </zzz>
Option <dev> has an arg </dev/zzz>
```

## getopts
A shell implementation of the *getopts(1)* built-in as found in most
shells, with a small extension: the list of arguments to parse may be
passed as an additional argument to the function. Without the
extension, the first argument after *optstring* is the option string
itself and the rest are the parameters being walked (the canonical
form used by most shells).

*optstring* is a list of short option characters, with an optional
trailing `:` after each character that takes an argument.

On each iteration the function sets *OPTOPT* to the character of the
recognized option and *OPTARG* to its argument, if any. When the end
of the option list is reached, the function returns 1 and *OPTIND* is
set to the position of the first non-option argument.

Example:
```
set -- -a -b -d 10 -e file1 file2

while getopts "abcd:e." "$@"; do
	echo "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
done

# at this point OPTIND points at the first non-option argument:
shift $((OPTIND - 1))
for arg in "$@"; do
	echo "Non-option argument <$arg>"
done
```

## getoptex
The same as *getopts* but with long-option support. In addition to
the short-option characters of *getopts* (same syntax), the
*optstring* may contain long-option names separated by spaces. A
trailing colon (`:`) after an option name means the option requires
an argument; a trailing `;` or `.` means the option may take an
argument but does not require one.

Example:
```
while getoptex "a; b; c; d: e. opt1 opt2 opt3 opt4: opt5." "$@"; do
	echo "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
done
```

# ENVIRONMENT
*GETOPT_ALLOW_UNKNOWN* - when set, unknown options are not reported
as errors; they are returned via *OPTUKN* at the end of the scan.

*GETOPT_ALLOW_ABBREV* - when set, long options may be abbreviated as
long as the abbreviation is unambiguous. This is enabled by default.

*GETOPT_ALLOW_ALTERNATIVE* - when set, long options may start with a
single `-` (equivalent to *getopt(1)* `-a`).

*GETOPT_POSIXLY_CORRECT* - when set, all remaining parameters are
treated as non-option parameters as soon as the first non-option
parameter is encountered.

*OPTIND*, *OPTOPT*, *OPTARG*, *OPTTYP*, *OPTUKN* - standard option
parsing state variables; see *getopt(1)* for the meanings.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
