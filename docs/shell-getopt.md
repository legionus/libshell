% SHELL-GETOPT
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #

getopt, getoptex, getopts, getsubopt - parses command options (enhanced)

# SYNOPSIS #

- getopt optstring parameters
- getopt [options] [--] optstring parameters
- getopt [options] -o|--options optstring [options] [--] parameters
- getsubopt optstring parameters
- getopts optstring name [args]
- getoptex optstring name [args]

# DESCRIPTION #
Collection of functions to parse commend line options.

## getopt ##
This function is used to parse command line options and to check for legal options.
Shell implementation of ***getopt (1)*** utility from the util-linux package. This
function is written to be as compatible as possible with ***getopt (1)*** utility. Usually
you can just replace ***getopt (1)*** without any modifications by this function.

Example:
```bash
TEMP=`getopt -n "$PROG" -o "v:,V,h" -l "verbose:,version,help" -- "$@"` || show_usage
eval set -- "$TEMP"

while :; do
    case "$1" in
        -h|--help) show_help
            ;;
        -v|--verbose) shift; verbose="$1"
            ;;
        -V|--version) print_version "$PROG"
            ;;
        *) fatal "Unrecognized option: $1"
            ;;
    esac
    shift
done
```

## getsubopt ##
Function parses suboption arguments from a string. This is a shell-implementation of ***getsubopt (3)***.

Example:
```bash
while getsubopt 'rw mode: path: dev:' 'rw,mode=755,path="/zzz xxx",dev=/dev/zzz'; do
    echo "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
done
```

## getopts ##
Shell implementation of ***getopts (1)*** utility. It's a built-in utility in some shells.

Example:
```bash
echo "Using getopt to parse arguments:"

while getopts "abcd:e." "$@"; do
    echo "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
done

shift $(($OPTIND-1))
set -- $@ ${OPTUKN-}

for arg in "$@"; do
    echo "Non option argument <$arg>"
done
```

## getoptex ##
This function is the same as **getopts**, but supports long options.

Example:
```bash
echo Using getoptex to parse arguments:

while getoptex "a; b; c; d: e. opt1 opt2 opt3 opt4: opt5." "$@"; do
    echo "Option <$OPTOPT> ${OPTARG:+has an arg <$OPTARG>}"
done

shift $(($OPTIND-1))
set -- $@ ${OPTUKN-}

for arg in "$@"; do
    echo "Non option argument <$arg>"
done
```

# ENVIRONMENT #

**GETOPT_ALLOW_UNKNOWN** - Ignore unknown options.

**GETOPT_ALLOW_ABBREV** - Long options may be abbreviated, as long as the abbreviation is not ambiguous.

**GETOPT_ALLOW_ALTERNATIVE** - Allow long options to start with a single `-'. See (getopt -a).

**GETOPT_POSIXLY_CORRECT** - If the is set, all remaining parameters are interpreted as non-option
parameters as soon as the first non-option parameter is found.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

