#-----------------------------------------------------------------------------------------------------------------------
#
# Bash Command Prompt Settings
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Sunday, September 01, 2019 at 07:49:02 PM PDT
#
# Description:
#
#   This file defines the format of the primary Bash command prompt (PS1), which is printed before each new command
#   input line. This also defines the secondary command prompt (PS2), which is printed before for line continuations,
#   which are used for multiline commands. Note that both of these are only relevant for interactive sessions.
#
#   The primary command prompt is setup to be nicely colorized and include additional information about the current
#   working directory, current user, current machine name, and Git repository information if the current directory is
#   inside a Git repository. The secondary command prompt is setup so that multiline commands can be properly copied and
#   pasted and so that line continuations are intended slightly. By default, the secondary command prompt includes a
#   character that mangles the command when trying to copy it; colored spaces are used instead.
#
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
# Terminal Colors and Modifiers
#-----------------------------------------------------------------------------------------------------------------------


# ANSI color and modifications codes for terminal text. Note that the \[ and \] delimiters tell Bash not to count the
# characters towards prompt's length. This is necessary for Bash to properly wrap long lines on the terminal.
CYAN="\\[$(tput setaf 6)\\]"                # Cyan color for text.
GREEN="\\[$(tput setaf 2)\\]"               # Green color for text.
MAGENTA_BACKGROUND="\\[$(tput setab 5)\\]"  # Magenta color for the terminal background.
NORMAL="\\[$(tput sgr0)\\]"                 # Return text to normal.
YELLOW="\\[$(tput setaf 3)\\]"              # Yellow color for text.


#-----------------------------------------------------------------------------------------------------------------------
# Primary Command Prompt
#-----------------------------------------------------------------------------------------------------------------------


# Set the terminal prompt. The current user is represented by \u, host by \h, and the current working directory by \w.
# `__git_ps1` is a function that display Git repository information.
export PS1="${GREEN}[\\u@\\h ${YELLOW}\\w${CYAN}\$(__git_ps1)${GREEN}]\\\$ ${NORMAL}"


#-----------------------------------------------------------------------------------------------------------------------
# Secondary Command Prompt
#-----------------------------------------------------------------------------------------------------------------------


# Set the prompt used for line continuations in the terminal (for multiline commands) so that multiline commands can be
# copied properly.
export PS2="${MAGENTA_BACKGROUND}$(printf " %.s" {1..8})${NORMAL}"
