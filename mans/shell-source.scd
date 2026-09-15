shell-source(3)

# NAME
source_if_executable, source_if_exists, source_if_notempty - functions
to source another script conditionally.

# SYNOPSIS
- source_if_executable file
- source_if_exists file
- source_if_notempty file

# DESCRIPTION
Common functions to source (include in the current shell environment)
another script, only when a condition on the file is satisfied.

## source_if_executable
Sources *file* in the current shell environment if the file is found
and has the execute permission bit set. If the file is not found or
is not executable, nothing is sourced and the function returns 0.
Otherwise the return status is that of the last command in the
sourced file.

Example:
```
WORKDIR=$(mktemp -d)
printf 'FOO=bar\n' > "$WORKDIR/f"
chmod +x "$WORKDIR/f"
source_if_executable "$WORKDIR/f"
echo "$FOO"                   # bar
rm -rf "$WORKDIR"
```

## source_if_exists
Sources *file* in the current shell environment if the file is found.
If the file is not found, nothing is sourced and the function
returns 0. Otherwise the return status is that of the last command
in the sourced file.

Example:
```
WORKDIR=$(mktemp -d)
printf 'FOO=bar\n' > "$WORKDIR/f"
source_if_exists "$WORKDIR/f"
echo "$FOO"                   # bar
source_if_exists /nonexistent
echo "not fatal: rc=$?"       # not fatal: rc=0
rm -rf "$WORKDIR"
```

## source_if_notempty
Sources *file* in the current shell environment if the file is found
and non-empty. A zero-byte file is treated the same as a missing
file: nothing is sourced and the function returns 0.

Example:
```
WORKDIR=$(mktemp -d)
: > "$WORKDIR/empty"
source_if_notempty "$WORKDIR/empty"
echo "empty: rc=$?"           # empty: rc=0
printf 'FOO=bar\n' > "$WORKDIR/f"
source_if_notempty "$WORKDIR/f"
echo "$FOO"                   # bar
rm -rf "$WORKDIR"
```

# NOTES
When *file* does not contain a slash it is resolved through *PATH*;
the first existing file in any *PATH* entry is used.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
