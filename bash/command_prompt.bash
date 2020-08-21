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
#   The process that starts Bash can also define an environment variable that gets prepended to the standard PS1,
#   `PS1_PREFIX`. This is useful for distinguishing between various context-based environments within the shell.
#
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
# Terminal Colors and Modifiers
#-----------------------------------------------------------------------------------------------------------------------


# ANSI color and modifications codes for terminal text. Note that the \[ and \] delimiters tell Bash not to count the
# characters towards prompt's length. This is necessary for Bash to properly wrap long lines on the terminal.
CYAN="\\[$(tput setaf 6)\\]"                # Cyan color for text.
GREEN="\\[$(tput setaf 2)\\]"               # Green color for text.
MAGENTA="\\[$(tput setaf 5)\\]"             # Magenta color for text.
MAGENTA_BACKGROUND="\\[$(tput setab 5)\\]"  # Magenta color for the terminal background.
NORMAL="\\[$(tput sgr0)\\]"                 # Return text to normal.
RED="\\[$(tput setaf 1)\\]"                 # Red color for text.
YELLOW="\\[$(tput setaf 3)\\]"              # Yellow color for text.


#-----------------------------------------------------------------------------------------------------------------------
# Primary Command Prompt
#-----------------------------------------------------------------------------------------------------------------------


# Gets the string for the prompt indicating the editing mode. Since Emacs is the default and standard, nothing is
# displayed in that case. When using Vi mode, it is displayed as a part of the prompt.
function get-editing-mode
{
    if (shopt -o -p vi > /dev/null); then
        printf '{vi} '
    fi
}


# Gets the string for the prompt indicating the Git information for the prompt, which can include the branch name and
# mode Git currently is in (merge, rebase, etc.). This is a simple wrapper around the Git-provided __git_ps1 that skips
# the function if the current working directory is on a mounted network share, because the operation can be quite slow.
function get-git-ps1
{
    local current_fs="$(df --print-type "$(pwd)" | cut -d ' ' -f 2 | tail -n 1)"
    if [[ "${current_fs}" == "cifs" || "${current_fs}" == "nfs" || "${current_fs}" == "afs" ]]; then
        return
    fi

    __git_ps1
}


# Set the terminal prompt. Note that this string is evaluated before each new terminal line is displayed, so command
# substitutions are escaped so they are evaluated each time. The prompt consists of an optional prefix that can be
# specified by the user, the current editing mode (only displayed if Vi editing mode is used), the current user (\u),
# the host (\h), the current working directory (\w), and Git information such as the current branch or commit and
# actions such as rebasing or merging if the current working directory is inside of a Git repository. The Git
# information comes from the `__git_ps1` defined by the Git package to get this information.
export PS1="${RED}${PS1_PREFIX}"
PS1+="${MAGENTA}\$(get-editing-mode)"
PS1+="${GREEN}[\\u@\\h"
PS1+=" ${YELLOW}\\w"
PS1+="${CYAN}\$(get-git-ps1)"
PS1+="${GREEN}]\\\$ ${NORMAL}"


#-----------------------------------------------------------------------------------------------------------------------
# Secondary Command Prompt
#-----------------------------------------------------------------------------------------------------------------------


# Set the prompt used for line continuations in the terminal (for multiline commands) so that multiline commands can be
# copied properly.
export PS2="${MAGENTA_BACKGROUND}$(printf " %.s" {1..8})${NORMAL}"
