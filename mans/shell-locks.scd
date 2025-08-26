shell-locks(3)

# NAME

fd_rlock, fd_lock, fd_trylock, fd_unlock, fd_is_locked - Functions for operating
with file locks.

# SYNOPSIS

- fd_rlock $num $filename
- fd_lock $num $filename
- fd_trylock $num $filename
- fd_unlock $fd_num
- fd_is_locked $filename

# DESCRIPTION

## fd_rlock
The function opens the file to the specified descriptor and takes a read lock.

## fd_lock
The function opens the file to the specified descriptor and takes a write lock.

## fd_trylock
The function opens the file to the specified descriptor and takes a write lock.
If the lock could not be taken, then the function failed.

## fd_unlock
Closes the descriptor and releases the lock.

## fd_is_locked
Checks whether a lock is present on the specified file.

# ENVIRONMENT

# AUTHOR
Authors and contributors of the programs included in the *libshell* package are listed
in the COPYING file.

# BUGS
Report bugs to the authors.

