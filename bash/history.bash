#-----------------------------------------------------------------------------------------------------------------------
#
# Bash History Settings
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Sunday, September 01, 2019 at 07:09:33 PM PDT
#
# Description:
#
#   This file contains the history settings for a Bash interactive session.
#
#   This sets up the Bash history to be unlimited, ignore and erase duplicate entries, and add some basic command
#   patterns to ignore for history.
#
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
# Command Patterns to Ignore
#-----------------------------------------------------------------------------------------------------------------------


# Create the list of commands to ignore when they are used without any arguments (including options without arguments).
IGNORED_NOARG_COMMANDS=(make ls ll dir cd 'git log' 'git clean' 'git status' 'git pull' 'git diff')
for cmd in "${IGNORED_NOARG_COMMANDS[@]}"
do
    IGNORED_COMMANDS+=":*([ \t])${cmd}*([0-9-_.])*([ \t])"
done

# Create a list of commands to ignore even when they are used with arguments. These are ones not worth repeating.
IGNORED_ARG_COMMANDS=(bg fg exit history man vman kill 'cd -')
for cmd in "${IGNORED_ARG_COMMANDS[@]}"
do
    IGNORED_COMMANDS+=":*([ \t])${cmd}*"
done


#-----------------------------------------------------------------------------------------------------------------------
# Bash History Settings
#-----------------------------------------------------------------------------------------------------------------------

# When adding new entries to the history, erase any duplicate values. Also, ignore any new entries that are a duplicate.
export HISTCONTROL="erasedups:ignoredups"

# Make the size of the shared history stored in the history file unlimited.
export HISTFILESIZE=-1

# Set the list of commands to ignore for new history entries, focusing on the items described above.
export HISTIGNORE="${HISTIGNORE}:${IGNORED_COMMANDS}:*([ \t])"

# Make the size of in-memory history of the current session unlimited.
export HISTSIZE=-1

# Set the format of the timestamps used in the history file.
export HISTTIMEFORMAT='%D:%T'

# Add to the command that is run before a new prompt is printed to the terminal to append the current history to the
# global history file. This ensures that new command windows will immediately have the history from other ones.
export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
