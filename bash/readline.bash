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


# Use FZF to select a set of file(s) to edit, and then open the files with Vim (they will setup as separate buffers). If
# the current readline buffer contains a single entry, then use that as the root path.
function fzf-edit
{
    # If specified, search from the specified path. If more than one argument is specified, then the arguments are
    # ignored (since the shortcut simply will pass in the whole line). Defaults to the current working directory.
    if [[ ${#} -eq 1 ]]; then
        local search_directory="${1}"
    else
        local search_directory="."
    fi

    # Verify the specified path is a directory.
    if [[ ! -d "${search_directory}" ]]; then
        printf "\nError: ${search_directory}: Specified path is not a directory.\n" 1>&2
        return 1
    fi

    # Define the command used to select the file(s) to edit. Note that the null character is used to delimit the outputs
    # so that all files with special characters can be handled properly.
    local fzf_cmd='command fd --color never --follow --hidden --no-ignore --type file --print0 ${FD_TEXT_IGNORE}
            --search-path "${search_directory}" | fzf ${FZF_DEFAULT_OPTS} --multi --height "40%" --reverse --read0 --print0'

    # Use the map file primitive to put the selected files into an array variable.
    local files=()
    IFS= mapfile -d $'\0' files < <(eval ${fzf_cmd})

    # Only attempt to open files if some have been selected by the user.
    if [[ ${#files[@]} -ne 0 ]]; then
        printf 'vim ' &&
        printf '%q ' "${files[@]}"
    fi
}


# A small wrapper around FZF's standard __fzf_cd__ function which extends that function to support specifying an
# alternate root directory from which to search, instead of the current working directory. This comes from whatever is
# on the command-line when the shortcut is invoked.
function fzf-cd
{
    # If specified, search from the specified path. If more than one argument is specified, then the arguments are
    # ignored (since the shortcut simply will pass in the whole line). Defaults to the current working directory.
    if [[ ${#} -eq 1 ]]; then
        local search_directory="${1}"
    else
        local search_directory="."
    fi

    # Verify the specified path is a directory.
    if [[ ! -d "${search_directory}" ]]; then
        printf "\nError: ${search_directory}: Specified path is not a directory.\n" 1>&2
        return 1
    fi

    # Use the FZF command to select the directory to change to. Note that the null chracter is used to delimit the
    # outputs so that directories with special characters can be handled properly.
    local directory="$(command fd --color never --follow --hidden --no-ignore --type directory ${FD_IGNORE} \
            --search-path "${search_directory}" | fzf ${FZF_DEFAULT_OPTS} --height "40%" --reverse --no-multi)"

    if [[ ! -z ${directory} ]]; then
        printf "cd %q" ${directory}
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

# Setup Alt-e as a shortcut to edit a file. The file is searched for with FZF and then opened up with Vim. If the line
# is not blank, then it is passed along to the function. This allows for paths to be specified where the search should
# be rooted.
bind '"\ee": "\C-a$(fzf-edit \C-e)\e\C-e\er\C-m"'

# Override's FZF's standard Alt-C shortcut for changing the directory (first the directory is searched for with FZF and
# then passed to CD). This is done to instead invoke a function that supports accepting an argument to specify a
# different search path than the current working directory.
bind '"\ec": "\C-a$(fzf-cd \C-e)\e\C-e\er\C-m"'
