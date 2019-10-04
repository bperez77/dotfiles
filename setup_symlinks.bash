#!/usr/bin/env bash

#-----------------------------------------------------------------------------------------------------------------------
#
# Setup Symbolic Links Script
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Thursday, October 03, 2019 at 11:24:36 PM PDT
#
# Description:
#
#   This script handles setting up symbolic links in the user's home directory to the configuration files in the
#   Dotfiles repository.
#
#   The symbolic links are created at the location of standard system configuration files (e.g. Bashrc, Git
#   configuration, Vim directory, etc.), so that the files in this repository are used as the configuration files for
#   the various programs. The created symbolic links use relative paths so that absolute paths are not hardcoded into
#   them, making them easier to migrate and move around if needed. The created symbolic links will overwrite any
#   existing files or directories at the paths, but a backup will be created in case they are still needed.
#
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
# Shell Settings
#-----------------------------------------------------------------------------------------------------------------------


# Quit the script if any command fails.
set -e

# When executing a pipeline of commands, the exit code from rightmost command to exit with a non-zero exit status,
# or 0 if all commands are successful. Normally, the exit code simply comes from the last command.
set -o pipefail

# Quit the script if any variable referenced is undefined.
set -u


#-----------------------------------------------------------------------------------------------------------------------
# Definitions
#-----------------------------------------------------------------------------------------------------------------------


# The directory where this script is located. Note: This only works when the script is run, not sourced.
SCRIPT_DIRECTORY="$(dirname "${0}")"

# Configuration files in this repository to create symbolic links for, typically in the home directory.
declare -A CONFIGURATION_PATHS=(
        ["${HOME}/.bash"]="${SCRIPT_DIRECTORY}/bash"
        ["${HOME}/.bashrc"]="${SCRIPT_DIRECTORY}/bashrc"
        ["${HOME}/.ctags.d"]="${SCRIPT_DIRECTORY}/ctags.d"
        ["${HOME}/.gdbinit"]="${SCRIPT_DIRECTORY}/gdbinit"
        ["${HOME}/.gitconfig"]="${SCRIPT_DIRECTORY}/gitconfig"
        ["${HOME}/.inputrc"]="${SCRIPT_DIRECTORY}/inputrc"
        ["${HOME}/.pythonstartup"]="${SCRIPT_DIRECTORY}/pythonstartup"
        ["${HOME}/.ssh/config"]="${SCRIPT_DIRECTORY}/ssh/config"
        ["${HOME}/.vim"]="${SCRIPT_DIRECTORY}/vim"
)


#-----------------------------------------------------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------------------------------------------------


###
# The main entrypoint for the script.
#
# This creates the symbolic links for all the repository's configuration files, linking them to paths where standard
# system configuration files are (e.g. Bashrc, Git configuration, etc.). If the links are already present, then nothing
# is done.
#
# The created symbolic links are made relative so that absolute paths aren't hardcoded into the links. This makes them
# easier to migrate and move around if needed.
###
function main
{
    # If the SSH directory does not exist, then create it before creating a symbolic link to the SSH configuration.
    if [[ ! -d "${HOME}/.ssh" ]]; then
        mkdir "${HOME}/.ssh"
    fi

    # Setup the symbolic links to the configuration files in this repository. The symbolic links are made relative so
    # absolute paths aren't hardcoded into the symbolic links.
    echo 'Setting up symbolic links for configuration files to the Dotfiles repository...'
    for source_path in "${!CONFIGURATION_PATHS[@]}"
    do
        local target_path="${CONFIGURATION_PATHS[${source_path}]}"

        # Get the directory where the link will be created (source) and the relative path from there to the target.
        local source_dir="$(dirname "${source_path}")"
        local target_relative_path="$(realpath --canonicalize-missing --no-symlinks --relative-to="${source_dir}" \
            "${target_path}")"

        # Change the directory to the source path's directory, so the created symbolic link can be relative. Overwrite
        # the file if it already exists, but create a backup in case the file shouldn't have been overwritten.
        pushd "${source_dir}" > /dev/null
        ln --verbose --symbolic --no-dereference --force --backup=numbered "${target_relative_path}" "${source_path}"
        popd > /dev/null
    done
}


#-----------------------------------------------------------------------------------------------------------------------
# Script Interface
#-----------------------------------------------------------------------------------------------------------------------


# Only run the main function is this script is being executed, not when it is sourced.
if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "${@}"
fi
