shell-run(3)

# NAME
run_if_executable, run_scripts - functions to run external scripts.

# SYNOPSIS
- run_if_executable file arg1 arg2
- run_scripts dir [args]

# DESCRIPTION
Common functions to run external programs and scripts.

## run_if_executable
Finds *file* (through *PATH* if the name contains no slash), and if
the found file is executable, runs it as an external command, passing
the remaining arguments. If the file is not found or is not
executable, nothing is executed and the function returns 0. Otherwise
the return status is that of the invoked command.

Example:
```
mkdir -p $WORKDIR/d &&
printf '#!/bin/sh\necho hello from script\n' > $WORKDIR/d/tool
chmod +x $WORKDIR/d/tool
run_if_executable /nonexistent-dir/tool
echo "not found: rc=$?"        # not found: rc=0
run_if_executable $WORKDIR/d/tool
# hello from script
```

## run_scripts
Runs all the regular files in *dir* that are executable and do not
match one of the *RUN_SCRIPTS_EXCLUDE* patterns, passing the remaining
arguments to each of them. Files are processed in sorted order. If a
script exits with a non-zero status, the function remembers the
failure and returns a non-zero status (status 1) at the end of the
scan, unless *SCRIPT_ERROR_FATAL* is set to `true`, in which case the
scan stops immediately. The *dir* argument is validated with
*opt_check_dir* (see `shell-args(3)`) and must refer to an existing
directory.

The behavior can be adjusted with the following global variables:

*RUN_SCRIPTS_EXCLUDE* - a list of shell patterns; any script whose
name matches one of them is skipped. The default value covers RPM
package files, editor backup files, and similar temporary files.

*SCRIPT_ERROR_FATAL* - set to `true` to make the function stop at the
first failing script and return its status. The default is `false`,
in which case the scan continues and the function returns a
non-zero status at the end of the scan.

Example:
```
mkdir -p $WORKDIR/d
printf '#!/bin/sh\necho A\n' > $WORKDIR/d/a.sh
chmod +x $WORKDIR/d/a.sh
printf 'not executable\n' > $WORKDIR/d/b.sh
printf '#!/bin/sh\necho skipped\n' > $WORKDIR/d/c.rpm
chmod +x $WORKDIR/d/c.rpm
printf '#!/bin/sh\necho skipped\n' > $WORKDIR/d/d~
chmod +x $WORKDIR/d/d~
run_scripts $WORKDIR/d
echo "rc=$?"                  # rc=0
# A
```

# NOTES
File names containing whitespace are not handled by *run_scripts*,
since the file list produced by `find(1)` is not quoted.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
