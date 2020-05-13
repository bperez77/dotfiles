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
# Bash History Settings
#-----------------------------------------------------------------------------------------------------------------------

# When adding new entries to the history, erase any duplicate values. Also, ignore any new entries that are a duplicate.
export HISTCONTROL="erasedups:ignoredups"

# Make the size of the shared history stored in the history file unlimited.
export HISTFILESIZE=-1

# Ignore whitespace only lines in addition to the standard history ignores.
export HISTIGNORE="${HISTIGNORE}:*([ \t])"

# Make the size of in-memory history of the current session unlimited.
export HISTSIZE=-1

# Set the format of the timestamps used in the history file.
export HISTTIMEFORMAT='%D:%T'

# Add to the command that is run before a new prompt is printed to the terminal to append the current history to the
# global history file. This ensures that new command windows will immediately have the history from other ones.
export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
