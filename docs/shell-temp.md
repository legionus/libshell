shell-temp(3)

# NAME

create_temporary - create a temporary file or directory

# SYNOPSIS

- create_temporary retvar [mktemp options]

# DESCRIPTION

## create_temporary
Function creates a temporary file or directory and stores the filename into *retvar* variable.

```
create_temporary workdir
```

To create temporary file:

```
create_temporary tempfile -t
```

# AUTHOR
Authors and contributors of the programs included in the *libshell* package are listed
in the COPYING file.

# BUGS
Report bugs to the authors.

