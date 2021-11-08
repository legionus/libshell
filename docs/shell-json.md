shell-json(3)

# NAME

json_foreach - function for streaming json parsing

# SYNOPSIS

- json_foreach
- json_foreach_handler type value
- json_get_last_name retvar
- json_get_full_name retvar [separator]

# DESCRIPTION

## json_foreach
The function consumes standard input to parse JSON and calls `json_foreach_handler` for each
simple value (`string`, `number`, `boolean` and `null`).

## json_foreach_handler
The function is a callback that is called for each JSON value. The function
receives the value type and the JSON value of the variable as arguments. Inside
the callback, you can get the field name by calling the `json_get_last_name`
or `json_get_full_name`.

## json_get_last_name
This is a helper that is meant to be called from the `json_foreach_handler`. It
puts into the `retvar` with the name of JSON field.

## json_get_full_name
Same as `json_get_last_name` but returns full JSON field name. The name is made
up of the parent names of the fields joined with a `separator`.

# AUTHOR
Authors and contributors of the programs included in the *libshell* package are listed
in the COPYING file.

# BUGS
Report bugs to the authors.

