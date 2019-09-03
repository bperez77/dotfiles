#-----------------------------------------------------------------------------------------------------------------------
#
# Bash-Specific Readline Settings
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Sunday, September 01, 2019 at 08:56:31 PM PDT
#
# Description:
#
#   This file contains the Readline (input) settings that are specific to Bash only. The general Readline settings are
#   contained in the Inputrc file.
#
#   This simply sets up some Bash-specific readline settings. This enables bracketed pasting for Bash, which allows for
#   pasting multi-line commands directly to the terminal, as all terminal escape sequences (including newlines) are
#   ignored when pasting text. The other thing that is setup Alt-e as the shortcut to use FZF to fuzzy find files to
#   edit with Vim.
#
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
# Helper Functions
#-----------------------------------------------------------------------------------------------------------------------


# Use FZF to select a set of file(s) to edit, and then open the files with Vim (they will setup as separate buffers).
function fzf-edit
{
    # Define the command used to select the file(s) to edit. Note that the null character is used to delimit the outputs
    # so that all files with special characters can be handled properly.
    local fzf_cmd='command fd --color never --follow --hidden --no-ignore --type file --print0 ${FD_TEXT_IGNORE} |
        fzf ${FZF_DEFAULT_OPTS} --height "40%" --reverse --read0 --print0'

    # Use the map file primitive to put the select files into an array variable.
    local files=()
    IFS= mapfile -d $'\0' files < <(eval ${fzf_cmd})

    # Only attempt to open files if some have been selected by the user.
    if [[ ${#files[@]} -ne 0 ]]; then
        printf 'vim ' &&
        printf '%q ' "${files[@]}"
    fi
}


#-----------------------------------------------------------------------------------------------------------------------
# Readline Settings
#-----------------------------------------------------------------------------------------------------------------------


# When pasting text, insert the text as a single string instead of treating each character as if had come from the
# keyboard. This prevents pasted characters from being interpreted as editing commands. For example, if
# pasted text has an embedded newline, this will prevent the line from automatically being entered in the terminal.
bind 'set enable-bracketed-paste on'


#-----------------------------------------------------------------------------------------------------------------------
# Keyboard Shortcuts and Bindings
#-----------------------------------------------------------------------------------------------------------------------

# Setup ALT-e as a shortcut to edit a file. The file is searched for with FZF and then opened up with Vim.
bind '"\ee": "\C-e\C-u$(fzf-edit)\e\C-e\er\C-m"'
