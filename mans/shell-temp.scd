shell-temp(3)

# NAME
create_temporary - create a temporary file or directory.

# SYNOPSIS
- create_temporary result_var [mktemp options]

# DESCRIPTION

## create_temporary
Calls `mktemp(1)` to create a temporary path and stores the
resulting name in the variable named by *result_var*.

When no options are given, the default is `-dt` (a new directory
under *TMPDIR* or */tmp*). Pass `-t` (without `-d`) to create a
regular file, and `-d` to force a directory. The option `-p DIR`
places the result inside *DIR* instead.

On each call, *create_temporary* registers the new path with an
internal cleanup list. A *signal* handler is installed the first time
any path is created; on *EXIT*, *HUP*, *INT*, *PIPE*, *QUIT* or
*TERM* all paths created by the current invocation are removed
(recursively) by the shell.

Example:
```
create_temporary working_dir                 # directory in /tmp
create_temporary data_file -t                # regular file in /tmp
create_temporary scratch_dir -d -p /scratch  # directory in /scratch
echo "working_dir=$working_dir"
echo "data_file=$data_file"
```

# NOTES
The basename is always of the form *$PROG.XXXXXXXX*, so the value
of *PROG* (defaulted by *shell-error* to basename of the shell)
determines the leading characters visible in the path.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
