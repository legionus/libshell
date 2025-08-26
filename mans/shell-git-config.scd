shell-git-config(3)

# NAME

git_config_append, git_config_count, git_config_get, git_config_list,
git_config_location_exists, git_config_parse, git_config_set,
git_config_unset, git_config_env, git_config_foreach, git_config_get_var,
git_config_get_subsections - collection of functions to work with a git-like config files

# SYNOPSIS

- git_config_append file name value
- git_config_count retname file name
- git_config_get retname file name
- git_config_list file [name]
- git_config_location_exists file name
- git_config_parse file
- git_config_parse_file file
- git_config_set file name value
- git_config_unset file name [value]
- git_config_env file
- git_config_foreach [name] [custom_handler]
- git_config_get_var retname section subsection name [{first|last|all=DELIM}]
- git_config_get_subsections section

# DESCRIPTION
The syntax of the configuration file corresponds to the *git-config (1)*.

The variables are divided into sections, wherein the fully qualified variable name
of the variable itself is the last dot-separated segment and the section name is
everything before the last dot. The variable names are case-insensitive, allow only
alphanumeric characters and -, and must start with an alphabetic character.
Some variables may appear multiple times; we say then that the variable is multivalued.

## git_config_append
Function adds another *value* with same *name* into config *file*.

## git_config_count
Function counts variable occurrences in specified config *file* and stores result into *retname* variable.

## git_config_get
Function gets variable from specified config *file* and stores result into *retname* variable.

## git_config_list
Lists values of variable in specified config *file*.

## git_config_location_exists
Function checks whether there is a specified variable in the configuration.

## git_config_parse
Function lists all names and variables in tab separated form.

## git_config_parse_file
Parses the git-like config file and calls *git_config_handler* for every value.

## git_config_handler
Default handler for *git_config_parse_file*.

## git_config_set
Function sets or adds *value* into config *file* with given *name*.

## git_config_unset
Function removes variable by *name* and optionally by *value*.

## git_config_env
Function parses config *file* and store it as shell variables to improve future access to values.
This is another way to get values from the config. It requires more memory since it places the config
parameters in shell variables. This can be useful if you often access config variables.

## git_config_foreach
Lists of variables speciRequires file parsing function.fied in the config.
Uses the result of parsing a file by the *git_config_env*.

## git_config_foreach_handler
Default handler for *git_config_foreach*.
This function may be overridden.

## git_config_get_var
Function stores value of config value into the *retname* variable.
Uses the result of parsing a file by the *git_config_env*.

## git_config_get_subsections
Function walkthrough all subsections in *section* and call *git_config_get_subsections_handler* function.
Uses the result of parsing a file by the *git_config_env*.

## git_config_get_subsections_handler
Default handler for *git_config_get_subsections*.
This function may be overridden.

# ENVIRONMENT

*GIT_CONFIG_GET_RAW* - Outputs values without decoding and unquoting.

*GIT_CONFIG_INCLUDE* - Allows include one config file from another by setting the special
include.path variable. The included file is expanded immediately, as if its contents had been
found at the location of the include directive.

# AUTHOR
Authors and contributors of the programs included in the *libshell* package are listed
in the COPYING file.

# BUGS
Report bugs to the authors.

