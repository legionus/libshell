shell-locks(3)

# NAME
fd_rlock, fd_lock, fd_trylock, fd_unlock, fd_is_locked - functions
for operating with file locks.

# SYNOPSIS
- fd_rlock fd_num filename
- fd_lock fd_num filename
- fd_trylock fd_num filename
- fd_unlock fd_num
- fd_is_locked filename

# DESCRIPTION
File locking utilities built around *flock(1)*. Each lock function
opens *filename* on the file descriptor *fd_num* and takes a lock of
the requested type. Note that the file is opened for reading in all
cases; the distinction between a read and a write lock is conveyed to
the kernel by the corresponding *flock* mode.

## fd_rlock
Takes a shared (read) lock with *flock(1)* mode `-s`. Several
processes may hold the lock on the same file at the same time.

## fd_lock
Takes an exclusive (write) lock with *flock(1)* mode `-x`. Only one
process may hold the lock at a time. The call blocks until the lock
is granted.

## fd_trylock
Takes an exclusive lock with *flock(1)* in non-blocking mode (`-n`).
If the lock is already held by another process, the function returns
a non-zero status instead of blocking.

## fd_unlock
Closes the file descriptor *fd_num*. Closing the descriptor releases
any lock that the current process holds through that descriptor.

## fd_is_locked
Returns 0 when the file is already exclusively locked (that is, an
attempt to acquire a non-blocking exclusive lock fails), and 1
otherwise.

Example:
```
lockfile=$PWD/scratch.lock

fd_lock 7 "$lockfile"
echo "lock acquired on fd 7"
fd_is_locked "$lockfile" && echo "locked" || echo "free"
fd_unlock 7
fd_is_locked "$lockfile" && echo "locked" || echo "free"
```

# NOTES
Every call to *fd_rlock*, *fd_lock* or *fd_trylock* opens a new file
descriptor and the caller is responsible for releasing it with
*fd_unlock*. Forgetting to unlock will leak the descriptor for the
lifetime of the shell process.

The functions are intended to be used together with *flock(1)*
compatible tools on the same file.

# AUTHOR
Authors and contributors of the programs included in the *libshell*
package are listed in the COPYING file.

# BUGS
Report bugs to the authors.
