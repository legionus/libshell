% LIBSHELL
% 3
% October 2016
% libshell
% Linux Programmer's Manual

# NAME #
libshell - the library of shell functions.

# DESCRIPTION #
The libshell is a set of the most commonly-used shell functions. All functions use minimum
of external utilities and written for POSIX shell.

The main idea is to get rid of implementing these functions in shell-scripts again and again,
and also to protect from common mistakes.

# STRUCTURE #
The library has modular structure. Each module used for own special purpose.
Some modules use the functionality of each other and load the necessary dependence.

# USAGE #
All libshell modules **MUST** be kept in the PATH and could be not executable. It really helps to include
these modules in the shell-program:

```bash
#!/bin/sh
. shell-error
. shell-getopt

# something useful ...
```

The **bash-completion** will not find these modules in the PATH, if they are not executable.

# AUTHOR #
Authors and contributors of the programs included in the **libshell** package are listed
in the COPYING file.

# BUGS #
Report bugs to the authors.

