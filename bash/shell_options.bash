#-----------------------------------------------------------------------------------------------------------------------
#
# Bash Shell Options
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Sunday, September 01, 2019 at 07:28:20 PM PDT
#
# Description:
#
#   This file contains the setup of shell options for a Bash interactive session. The options in this file are all
#   Bash-specific.
#
#   This sets a variety of useful and convenient options for improving the user experience. Some notable ones are
#   enabling the '**' glob pattern for recursively matching any number of subdirectories, spelling simple typos for both
#   changing directories and tab completion, and enabling completion of hostnames from the `/etc/hosts` file.
#
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
# Shell Options
#-----------------------------------------------------------------------------------------------------------------------

# If a command name matches a directory, then automatically cd into that directory. This saves needing to prefix
# directory names with cd; they can be typed directly into the shell to change the directory.
shopt -s autocd

# If the argument to cd does not match a directory name, then it is treated as a variable if its name matches one. This
# saves needing to type the $ before the variable name when changing the directory to a variable's value.
shopt -s cdable_vars

# Fix simple spelling errors when using the change directory command.
shopt -s cdspell

# Check the window size after each command, and adjust the text as necessary (for window resizes).
shopt -s checkwinsize

# Append to the history file on exit, rather than overwriting it. This ensures that the history is saved across
# multiple sessions of the shell.
shopt -s cmdhist

# Fix simple spelling errors when using tab completion on directories.
shopt -s dirspell

# Allow for the extended globbing patterns for the command-line, which allow for lists of glob patterns to be used.
shopt -s extglob

# Allow for the recursive '**' glob pattern, which matches to 0 or more subdirectories (in a file expansion context).
shopt -s globstar

# Save any multi-line commands to the history file as a single entry, so it can be easily recalled and used again.
shopt -s histappend

# Enable tab completion of hostnames from the /etc/hosts file, after an '@' character.
shopt -s hostcomplete
