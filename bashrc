#-----------------------------------------------------------------------------------------------------------------------
#
# Bash Runcom/Run Commands (RC) File
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Monday, May 29, 2013 at 10:45:40 AM EDT
#
# Description:
#   This file is executed when a BASH shell is started up, and sets the settings, command aliases, and environment
#   variables for the shell session.
#
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
# Files to Execute (Default Values)
#-----------------------------------------------------------------------------------------------------------------------

# If this shell session is non-interactive, then don't run the Bashrc. Relevant environment variables should be
# inherited from the parent process.
if [[ -z "${PS1}" ]]; then
    return
fi

# Source the system-wide defaults if there is a Bashrc for it.
if [[ -f '/etc/bashrc' ]]; then
    source '/etc/bashrc'
fi

# Source any aliases that are defined in a separate file.
if [[ -f "${HOME}/.bash_aliases" ]]; then
    source "${HOME}/.bash_aliases"
fi

# If the current shell is a POSIX shell, source the system-wide defaults for tab-completion for commands.
if [[ -f '/etc/bash_completion' ]] && (! shopt -oq posix); then
    source '/etc/bash_completion'
fi

# Source the FZF fuzzy finder settings if there is a FZF Bash file.
if [[ -f "${HOME}/.fzf.bash" ]]; then
    source "${HOME}/.fzf.bash"
fi

#-----------------------------------------------------------------------------------------------------------------------
# User Settings
#-----------------------------------------------------------------------------------------------------------------------


# Source the various user settings files.
source "${HOME}/.bash/command_prompt.bash"
source "${HOME}/.bash/history.bash"
source "${HOME}/.bash/readline.bash"
source "${HOME}/.bash/shell_options.bash"
source "${HOME}/.bash/tab_completion.bash"


#-----------------------------------------------------------------------------------------------------------------------
# General Environment Variables
#-----------------------------------------------------------------------------------------------------------------------

# Set the default editor used in programs to be Vim, such as the editor used for editing Git commit messages.
export EDITOR='vim'

# The directory where all user-local installed programs and related files are located.
export USER_LOCAL_DIRECTORY="${HOME}/.local"

# The startup file to use before running Python. This enables persistent Python command history and tab completion.
export PYTHONSTARTUP="${HOME}/.pythonstartup"

# A good heuristic for the number of threads to use when compiling code in parallel (especially with Makefiles).
export THREADS=$((2 * $(getconf _NPROCESSORS_ONLN)))

# Lists of glob patterns to use for ignoring files and directories for copy commands, file finding commands, and text
# editing commands, respectively. The text editing list is exported to Vim for its wild ignore option.
COPY_IGNORE_LIST='*~ *.bak *.mod.c *.o *.o.* *.pyc __pycache__ .*.swp'
FIND_IGNORE_LIST='.git .hg .svn'
export TEXT_IGNORE_LIST="${COPY_IGNORE_LIST} ${FIND_IGNORE_LIST}"

# Setup the default commands used for the various FZF shortcuts and commands to use FD and respect an ignore list.
FD_IGNORE="$(echo ${FIND_IGNORE_LIST[@]} | sed -e "s/[^ ]\\+/--exclude &/g")"
FD_TEXT_IGNORE="$(echo ${TEXT_IGNORE_LIST} | sed -e "s/[^ ]\\+/--exclude &/g")"
export FZF_ALT_C_COMMAND="command fd --color never --follow --hidden --no-ignore --type directory ${FD_IGNORE}"
export FZF_CTRL_T_COMMAND="command fd --color never --follow --hidden --no-ignore ${FD_IGNORE}"
export FZF_DEFAULT_COMMAND="${FZF_CTRL_T_COMMAND}"

# Enable multi-select mode by default for the standard FZF command and the CTRL-T shortcut.
export FZF_CTRL_T_OPTS="--multi"
export FZF_DEFAULT_OPTS="${FZF_CTRL_T_OPTS}"

# Set FZF's reverse history search (CTRL-R) shortcut to preview commands, as some of them may be too long to fit on the
# terminal screen. Also, allow for this preview to be toggled with '?'.
export FZF_CTRL_R_OPTS='--preview "echo {}" --preview-window "down:3:wrap"'

# The directory where Stow (manager for manually installed programs) looks for packages by default. This is nested
# inside of the local directory to make installation easy.
export STOW_DIR="${USER_LOCAL_DIRECTORY}/stow"

#-----------------------------------------------------------------------------------------------------------------------
# Path Variables
#-----------------------------------------------------------------------------------------------------------------------

# Add the user-local installed executables and programs to the executable, manual, and library paths.
export PATH="${USER_LOCAL_DIRECTORY}/bin${PATH:+:${PATH}}"
export MANPATH="${USER_LOCAL_DIRECTORY}/share/man${MANPATH:+:${MANPATH}}"
export LD_LIBRARY_PATH="${USER_LOCAL_DIRECTORY}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

# Add the Git custom subcommands to the PATH. These will be picked up by Git.
export PATH="${HOME}/.git_subcommands:${PATH}"

# The man path must be prefixed by a colon in order for the standard paths to be included (this includes man paths from
# the system configuration files).
export MANPATH=":${MANPATH}"

# Add the bin scripts directory to the executable path, where any miscellaneous user-created executables may be.
export PATH="${HOME}/bin/scripts:${PATH}"

# Add the path to Git's diff-highlight program, used for getting word-level highlighting in diffs.
export PATH="/usr/share/doc/git/contrib/diff-highlight/:${PATH}"

# Add the paths for the installed Arduino studio, MATLAB, Altera Quartus, and Eagle programs to the executable path.
export PATH="/usr/bin/Arduino/arduino:${PATH}"
export PATH="/usr/local/MATLAB/R2015a/bin/:${PATH}"
export PATH="/opt/Altera/15.1/quartus/bin/:${PATH}"
export PATH="/opt/eagle-7.5.0/bin/:${PATH}"

# Add the various Xilinx tools (Vivado, HLS, SDK, cross-compiler) to the executable path.
XILINX_ROOT='/opt/Xilinx/'
XILINX_VERSION='2017.2'
export PATH="${XILINX_ROOT}/Vivado/${XILINX_VERSION}/bin/:${PATH}"
export PATH="${XILINX_ROOT}/SDK/${XILINX_VERSION}/gnu/arm/lin/bin/:${PATH}"
export PATH="${XILINX_ROOT}/SDK/${XILINX_VERSION}/bin/:${PATH}"
export PATH="${XILINX_ROOT}/Vivado_HLS/${XILINX_VERSION}/bin/:${PATH}"

# Add the Rust toolchain and any Rust programs installed with Cargo to the executable path.
export PATH="${HOME}/.cargo/bin:${PATH}"

# Add the user-local Go programs and libraries to Go path, and add the installed binaries to the executable path.
GO_USER_DIRECTORY="${HOME}/.go"
export GOPATH="${GO_USER_DIRECTORY}${GOPATH:+:${GOPATH}}"
export PATH="${GO_USER_DIRECTORY}/bin:${PATH}"

# Add the programs for the manually installed C0 and SML/NJ languages to the executable path.
export PATH="/usr/share/smlnj/bin/:${PATH}"
export PATH="/usr/share/cc0/bin/:${PATH}"

#-----------------------------------------------------------------------------------------------------------------------
# Programming and Development Tool Aliases
#-----------------------------------------------------------------------------------------------------------------------

# Runs a Python script with the Python debugger (PDB), which is used for line debugging (both for Python 2.x and 3.x).
alias python-pdb='python -m pdb -c continue'
alias python3-pdb='python3 -m pdb -c continue'

# Aliases for GCC and G++ to both compile code with strict warnings and with all debug flags enabled.
GCC_SAFE_FLAGS='-Wall -Werror -Wextra -std=gnu99'
GCC_DEBUG_FLAGS="${GCC_SAFE_FLAGS} -g -ggdb -O0"
alias gcc-safe="gcc ${GCC_SAFE_FLAGS}"
alias gcc-debug="gcc ${GCC_DEBUG_FLAGS}"
alias g++-safe="g++ ${GCC_SAFE_FLAGS}"
alias g++-debug="g++ ${GCC_DEBUG_FLAGS}"

# A version of the Valgrind command that uses all of the relevant checks for debugging C/C++ code.
alias valgrind-debug='valgrind --track-origins=yes --track-fds=yes --leak-check=full'

# Runs the Python linter command and only displays error and warning messages (style guidelines are ignored).
alias pylint-dbg='python -m pylint --reports=no --score=no --disable=C,R'
alias pylint3-dbg='python3 -m pylint --reports=no --score=no --disable=C,R'

# Aliases for running Makefiles to cross-compile C/C++ code for ARM and Android.
alias make-arm='make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-'
alias make-aarch64='make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-'
alias make-android='make ARCH=arm CROSS_COMPILE=arm-linux-androideabi-'

# Changes directory to the top-level/root of the current Git repository, if the current working directory is under one.
alias git-root='git rev-parse --show-cdup > /dev/null && cd ./$(git rev-parse --show-cdup)'

# Setup the LaTeX compilation commands to be compatible with the Minted and Pygments syntax highlighters by default.
alias pdflatex='pdflatex -shell-escape'
alias latex='latex -shell-escape'

# Setup the Readline wrapper so that it maintains a large history, doesn't repeat duplicates, and handles ANSI color
# codes by default.
alias rlwrap='rlwrap --always-readline --histsize 1000000 --history-no-dupes 2 --ansi-colour-aware'

# Create aliases for commands that wraps them with the Readline library. This is useful for commands that utilize a
# REPL, but do not provide Readline functionality. This will give the commands persistent history and tab completion.
RLWRAP_COMMANDS=(lua smlnj coin sim240)
for cmd in "${RLWRAP_COMMANDS[@]}"
do
    eval "alias ${cmd}='rlwrap --history-filename \"${HOME}/.$(basename ${cmd})_history\" ${cmd}'"
done

# MATLAB does not cooperate well with disowning, so simply launch the command with its output redirected.
function matlab
{
    matlab "$@" &> /dev/null &
}

# Runs the command-line (no GUI) version of MATLAB.
alias matlab-shell='command matlab -nodisplay'

#-----------------------------------------------------------------------------------------------------------------------
# General Aliases
#-----------------------------------------------------------------------------------------------------------------------

# Allow aliases to be used with the Sudo command. This is done by adding a space at the end of the alias.
alias sudo='sudo '

# Setup the ls command to use color higlighting and sort files numerically in a natural way by default.
alias ls='ls --color=auto -v'

# Setup the various grep commands to use color highlighting by default.
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add some shortcut aliases for default options for the ls command. This includes adding displaying of metadata.
alias ll='ls --almost-all --classify -l'
alias la='ls --all --classify -l'
alias l='ls -C --classify'

# Make sure that the remove, move, and copy commands prompt before deleting/overwriting files by default. Also, make
# sure the copy command preserves all the properties of the files it copies by default.
alias rm='rm --interactive'
alias mv='mv --interactive'
alias cp='cp --archive --interactive'

alias diff='diff --color=auto --report-identical-files'

# Setup a shorter alias for Vim, and setup an alias for Emacs to open in the terminal, instead of a GUI window.
alias vi='vim'
alias emacs='emacs24 --no-window-system'

# Open an empty Vim buffer for creating a Git commit message. This sets the file type appropriately.
alias vim-commit="vim -c 'setlocal filetype=gitcommit'"

# Setup the FD command to follow symbolic links and include most files in its search by default.
alias fd="fd --follow --hidden --no-ignore --show-errors ${FD_IGNORE}"

# Perform a FD file search only on file not ignored by Git. This search is performed from the root of repository.
# In order to specify other paths, the `--search-path` flag must be used.
function fd-git
{
    # Determine if the current working directory is under a Git repository, and get the relative path to the root.
    local git_root=$(git rev-parse --show-cdup)
    if [[ $? -ne 0 ]]; then
        exit_code=${?}
        printf "Error: Current working directory is not under a Git repository.\n" 1>&2
        return ${exit_code}
    fi

    # If the git root result is empty (from being at the root of the repository), then make sure '.' is specified.
    local args=("${@}")
    command fd --follow --hidden ${FD_IGNORE} --search-path ${git_root:-.} "${args[@]}"
}

# Setup the Ripgrep command to follow symbolic links and include most files in its search by default.
RIPGREP_IGNORE="$(echo ${FIND_IGNORE_LIST[@]} | sed -e "s/[^ ]\\+/--iglob !&/g")"
alias rg="rg --follow --hidden --no-ignore ${RIPGREP_IGNORE}"
alias ripgrep='rg'

# Perform a Ripgrep search only on files not ignored by Git. This search is performed from the root of the repository.
function rg-git
{
    # Check that the pattern was specified by the user, and use the Ripgrep command to generate the usage.
    local nargs=${#}
    if [[ ${nargs} -eq 0 ]]; then
        rg
        return $?
    fi

    # Determine if the current working directory is under a Git repository, and get the relative path to the root.
    local git_root=$(git rev-parse --show-cdup)
    if [[ $? -ne 0 ]]; then
        exit_code=${?}
        printf "Error: Current working directory is not under a Git repository.\n" 1>&2
        return ${exit_code}
    fi

    local args=("${@}")
    command rg --follow --hidden ${RIPGREP_IGNORE} "${args[@]}" ${git_root}
}
alias ripgrep-git='rg-git'

# Perform a fuzzy file search with FZF only on files not ignored by Git. This search is performed from the root of the
# Git repository.
alias fzf-git='rg-git --files 2> /dev/null | command fzf --multi'

# Setup the dd command to show progress of the data movement by default.
alias dd='dd status=progress'

# Setup the Dmesg command so that the kernel log messages have human-readable timestamps by default.
alias dmesg='dmesg --ctime --color=always'

# Setup the secure copy command to preserve file metadata and recursively copy data.
alias scp='scp -p -r'

# Setup the remote sync command to preserve file metadata, show incremental progress, and exclude files by default.
RSYNC_EXCLUDE="$(echo ${COPY_IGNORE_LIST[@]} | sed -e 's/[^ ]\+/--exclude "&"/g')"
alias rsync="rsync --recursive --archive --hard-links --acls --xattrs --checksum --human-readable --human-readable \
        --info=progress2 ${RSYNC_EXCLUDE[@]}"

# Remote sync and mirror the destination to the source. This means any files present on the destination, but not in the
# source are deleted (along with excluded files). Normally, these files would remain.
alias rsync-mirror='rsync --delete --delete-excluded'

# Display the true progress when transferring data with remote sync.  Normally, it will only display incremental
# progress, as it scans directory contents incrementally. This forces the command to first scan the source directories
# before beginning the transfer, which naturally can require significantly more memory.
alias rsync-progress='rsync --no-inc-recursive'

# Setup the Feh image viewer to scale the image down to the screen size by default.
alias feh='feh --scale-down'

# Setup several shortcut aliases for navigating up parent directories (one alias for each level of directories). These
# aliases are of the format ..1, ..2, ..3, etc.
MAX_DIRS=20
PARENT_DIR_STRING="../"
for i in $(seq 1 ${MAX_DIRS})
do
    eval "alias ..${i}='cd ${PARENT_DIR_STRING}'"
    PARENT_DIR_STRING+="../"
done

# Formats a list of one or more text files according to the standard format. This converts all tabs to spaces, line
# endings to Unix-style, and strips all extraneous whitespace and extra blank lines (this is implicit in the Vimrc).
function format-text-files
{
    local nargs=${#}
    if [[ ${nargs} -eq 0 ]]; then
        echo 'Error: No text files specified.'
        echo 'Usage: $(basename ${0}) <text_file1> [text_file2 text_file3 ...]'
        return 1
    fi

    local text_files=("${@}")
    for text_file in "${text_files[@]}"
    do
        vim -c ':retab' -c 'set ff=unix' -c ':wq' ${text_file}
    done
}

# Runs an arbitrary command and generates a popup window when the command finshes with the command's exit status.
function notify
{
    # Check that the proper number of command line arguments was specified.
    local nargs=$#
    if [[ ${nargs} -eq 0 ]]; then
        echo 'Error: No command specified.'
        echo 'Usage: notify <cmd> [cmd_arg1 cmd_arg2 ...]'
        return 1
    fi

    # Get the command, its name without the path, and all of the arguments from the command.
    local cmd="${1}"
    local cmd_name="$(basename ${1})"
    local args=("${@:2}")

    # Use eval to expand the command if it an alias, and quote the arguments array appropriately to preserve any
    # embedded quotes. Run the command to completion, and then open popup window to indicate it has finished.
    eval "${cmd}" '"${args[@]}"'
    zenity --info --text "The command '${cmd_name}' has finished with exit status '${?}'."
}

# Variant of the notify function that uses a desktop (toast) notification instead of a popup window.
function notify-desktop
{
    # Check that the proper number of command line arguments was specified.
    local nargs=$#
    if [[ ${nargs} -eq 0 ]]; then
        echo 'Error: No command specified.'
        echo 'Usage: notify <cmd> [cmd_arg1 cmd_arg2 ...]'
        return 1
    fi

    # Get the name of the command (without the path) and the full command.
    local cmd="${1}"
    local cmd_name="$(basename ${1})"
    local args=("${@:2}")

    # Use eval to expand the command if it an alias, and quote the arguments array appropriately to preserve any
    # embedded quotes. Run the command to completion, and then send a desktop notification when it finishes.
    eval "${cmd}" '"${args[@]}"'
    notify-send "The command '${cmd_name}' has finished with exit status '${?}'."
}

# Changes the root directory and binds parts of the original root file system to the faked root filesystem, and unmount
# them when done (it is very important that they are unmounted). This provides common kernel pseudofiles, and gives an
# environment comparable to a virtual machine when combined with the QEMU static binary.
function chroot-full
{
    # Check that the user has specified the proper number of command line arguments.
    local num_args=${#}
    if [[ ${num_args} -ne 1 ]]; then
        echo 'Error: Improper number of command line arguments'
        echo 'Usage: $(basename ${0}) <new_root_path>'
        return 1
    fi

    # Get the new root to use the filesystem, and declare the mount points to bind.
    local fs_root="${1}"
    local mount_points=('/sys' '/proc' '/dev' '/dev/pts' '/etc/resolv.conf')

    # Bind the mount points from the original filesystem to the faked root filesystem.
    for mount_point in "${mount_points[@]}"
    do
        sudo mount -o bind ${mount_point} "${fs_root}/${mount_point}"
    done

    # Change the root directory to the specified location, forcing the use of the C locale.
    sudo LC_ALL=C chroot "${fs_root}"

    # Unmount all of the bound mount points from the faked root filesystem.
    for mount_point in "${mount_points[@]}"
    do
        exit_status=1
        while [ ${exit_status} -ne 0]
        do
            sudo umount "${fs_root}/${mount_point}"
            exit_status=${?}
        done
    done
}

# Compiles a markdown file into HTML and then renders it in the system default browser.
function markdown-view
{
    pandoc "${@}" | bcat
}

# Create functions for commands that will run them in the background, disown them, and redirect their output to
# /dev/null by default. This is useful for launching GUI commands from the shell (e.g. Evince).
GUI_COMMANDS=(evince quartus arduino vmware virtualbox libreoffice gimp makerware kile qtspim spotify kicad gedit meld
        keepassx eclipse krop feh picard)
for cmd in "${GUI_COMMANDS[@]}"
do
    eval "function ${cmd} {
        nohup ${cmd} \"\$@\" &> /dev/null &
    }"
done

#-----------------------------------------------------------------------------------------------------------------------
# SSH and Networking Aliases
#-----------------------------------------------------------------------------------------------------------------------

# Restarts the network service. This restarts WiFi and can help deal with poor or lost connections, when the driver
# and/or software gets into a bad state.
alias wifi-restart='sudo service networking restart'

# SSH with X11 forwarding enabled (GUI windows opened on the remote server display locally).
alias ssh-x='ssh -X'

# Open and close a persistent SSH connection that can be utilized by multiple commands. The path
# to the connection file is unique, where %r is the remote user, %h is the remote host, and %p is the port number used.
SSH_CONNECTION_PATH='${HOME}/.ssh/ssh-%r-%h-%p'
alias ssh-open="ssh -M -f -N -o ControlPath=${SSH_CONNECTION_PATH}"
alias ssh-close="ssh -S ${SSH_CONNECTION_PATH} -O exit"

# Versions of the remote sync and secure copy commands that utilize a previously setup persistent SSH connection.
alias rsync-per="rsync --rsh=\"ssh -o ControlPath=${SSH_CONNECTION_PATH}\""
alias scp-per="scp -o ControlPath=${SSH_CONNECTION_PATH}"

# Shuts down a computer in Wake on LAN (WoL) mode, which allows the computer to be turned on from the network with the
# appropriate "magic packet".
alias wol-poweroff="sudo ethtool -s \$(ifconfig | grep '^e' | awk '{print \$1}') wol g && sudo poweroff"

# Turns on any computers on the local network that were previously shut down in Wake on LAN mode. One MAC address per
# machine is required to wake them up.
alias wol-poweron='wakeonlan -i 192.168.2.255'

# Fetches all the files under a given directory on a website with the web get command.
alias wget-dir='wget --recursive i--no-host-directories --no-directories --no-parent --execute robots=off'

# Downloads a file in parallel from a website using the maximum possible number of connections and threads.
MAX_DOWNLOAD_CONNECTIONS=16
alias parallel-download="aria2c --max-connection-per-server=${MAX_DOWNLOAD_CONNECTIONS} --split=${MAX_DOWNLOAD_CONNECTIONS}"

# Randomizes the MAC address of the specified device.
function randomize-mac
{
    nargs=${#}
    if [[ ${nargs} -ne 1 ]]; then
        echo 'Error: Improper number of command line arguments specified.'
        echo 'Usage: randomize-mac <device>'
        return 1
    fi

    device="${1}"
    sudo ifconfig "${device}" down &&
    (sudo macchanger --another "${device}"
    sudo ifconfig "${device}" up)
}

#-----------------------------------------------------------------------------------------------------------------------
# Disk Utility Aliases
#-----------------------------------------------------------------------------------------------------------------------

# Safely removes a disk device by its device name (e.g. /dev/sdb). This only works for non-USB storage devices.
alias safe-remove='udisksctl power-off --block-device'

# Mounts Carnegie Mellon University's AFS volume.
CMU_AFS_DOMAIN='andrew.cmu.edu'
alias mount-afs="sudo service openafs-client start && kinit && aklog && aklog ${CMU_AFS_DOMAIN}"

# Aliases for mounting and unmounting the windows partition in a dual boot setup. For safety (to prevent accidental
# deletions), the partition is mounted with the root as the owner.
WINDOWS_PARTITION='/dev/sda2'
alias mountwin="sudo mount --types ntfs --options umask=022 ${WINDOWS_PARTITION} /mnt/windows"
alias unmountwin="sudo umount ${WINDOWS_PARTITION}"

# Aliases for mounting and unmounting a Google Drive account's contents as a folder in the filesystem. For safety (to
# prevent accidental deletions), the drive is mounted with the root as the owner.
GDRIVE_MOUNT='/mnt/gdrive'
alias mount-gdrive="sudo google-drive-ocamlfuse -o default_permissions,allow_other,umask=022 ${GDRIVE_MOUNT}"
alias umount-gdrive="sudo fusermount -u ${GDRIVE_MOUNT}"

#-----------------------------------------------------------------------------------------------------------------------
# Windows Subsystem for Linux (WSL) Settings
#-----------------------------------------------------------------------------------------------------------------------

# Determine if the shell is being run under Microsoft's Windows Subsystem for Linux (WSL)
SHELL_IS_WSL_BASH=$(uname -a | grep --quiet --regexp='\<Microsoft\>' --regexp='\<WSL\>'; echo $?)
if [[ ${SHELL_IS_WSL_BASH} -eq 0 ]]; then

    # Change the ls colors so that other-writable directories will not be highlighted in green, and instead appear as
    # normal directories. This is done because files on the Windows drives will not have proper permissions.
    eval $(dircolors -b)
    export LS_COLORS="${LS_COLORS}:ow=01;34"

    # Set the display variable to the local host so Xming can be used with X11-forwarding to display GUI applications.
    export DISPLAY='localhost:0'

    # The location where the C drive is mounted in the WSL.
    export C_DRIVE='/mnt/c'

    # The location of the Window User's home directory in the WSL (assumes that the usernames match).
    export WINDOWS_HOME="${C_DRIVE}/Users/${USER}"

    # Convert an argument in a WSL command (including the program path) to the appropriate representation to run it in a
    # Windows command. Any symbolic links are resolved in the path, and drive paths are replaced with the Windows drive
    # letter. If the argument is not a path, then it is returned as-is. Forward slashes are converted to backslashes if
    # specified by the second argument.
    function convert-wsl-argument
    {
        local arg="${1}"
        local convert_slashes="${2:-false}"

        # Do not convert arguments with URL strings =, as double slashes will be converted to single slashes. Also, do
        # not convert arguments that contain a colon character in them, as will not be WSL paths.
        if [[ "${arg}" =~ ^(file?|ftp|http|https|ssh)://.* || "${arg}" =~ .*:.* ]]; then
            echo "${arg}"
            return
        fi

        # Based on if slashes should be converted, determine the appropriate substitution.
        if [[ "${convert_slashes}" == 'true' ]]; then
            local sed_regexes='-e s|^/mnt/\([a-zA-Z]\)/*|\1:\\|g -e s|/|\\|g'
        else
            local sed_regexes='-e s|^/mnt/\([a-zA-Z]\)/*|\1:/|g'
        fi

        local no_symlink_arg="$(realpath --quiet --canonicalize-missing --relative-base="$(pwd)" -- "${arg}")"
        local windows_arg="$(echo "${no_symlink_arg}" | sed ${sed_regexes})"

        # Return the argument by printing it to stdout.
        echo "${windows_arg}"
    }

    # Converts a command for a native Windows program launched from the WSL to one that is suitable to be run. The new
    # command is returned as statement that evaluates to an array (e.g. eval "var=$(convert-wsl-cmd <cmd ...>)").
    function convert-wsl-cmd
    {
        # Convert the program path to a Windows path, and additional convert forward slashes to back slashes.
        # Resolve any symbolic links in the program path, and convert the path from a Unix-style to Windows-style.
        local cmd=("${@}")
        local new_cmd="('$(convert-wsl-argument "${cmd[0]}" "true")'"

        # Convert each argument of the command to a Windows path (if applicable), but preserve forward slashes.
        for arg in "${cmd[@]:1}"
        do
            new_cmd+=" '$(convert-wsl-argument "${arg}")'"
        done

        # Return the converted command by printing the statement that evaluates to the equivalent array to stdout.
        new_cmd+=")"
        echo ${new_cmd}
    }

    # Runs a native Windows program from within the WSL in the same command window, ensuring smooth interoperability.
    function run-windows-cmd
    {
        # Convert the command and its arguments to Windows style.
        local cmd=("${@}")
        eval "local new_cmd=$(convert-wsl-cmd "${cmd[@]}")"

        # Run the command in the same command window.
        cmd.exe /C "${new_cmd[@]}"
    }

    # Starts a native Windows program from within the WSL in a separate command window, ensuring smooth interoperability.
    function start-windows-cmd
    {
        # Convert the command and its arguments to Windows style.
        local cmd=("${@}")
        eval "local new_cmd=$(convert-wsl-cmd "${cmd[@]}")"

        # Run the command in a separate command window. The K switch is used so that the command prompt window stays
        # open after the command completes.
        cmd.exe /C start cmd.exe /K "${new_cmd[@]}"
    }
fi

#-----------------------------------------------------------------------------------------------------------------------
# Git Bash (Windows) Settings
#-----------------------------------------------------------------------------------------------------------------------

# Determine if the shell is being run under Git Bash (Windows).
SHELL_IS_GIT_BASH=$(uname -s | grep --quiet '^MINGW'; echo $?)
if [[ ${SHELL_IS_GIT_BASH} -eq 0 ]]; then

    # The location where the C drive is mounted in Git Bash.
    export C_DRIVE='/c'

    # The location of the Window User's home directory in Git Bash.
    export WINDOWS_HOME="${HOME}"

    # Converts a command for a native Windows program launched from Git Bash to one that is suitable to be run. The new
    # command is returned as a string on standard output.
    function convert-git-bash-cmd
    {
        # If applicable, convert the program's path from a Unix-style to a Windows-style path and replace a drive path
        # with the equivalent Windows drive letter.
        local cmd=("${@}")
        local new_cmd="$(echo ${cmd[0]} | sed -e 's|^/\([a-zA-Z]\)/\+|\1:\\|' -e 's|/|\\|g') "

        # Replace any drive paths in each element of the command with the equivalent Windows drive letter.
        for elem in "${cmd[@]:1}"
        do
            new_cmd+="\"$(echo ${elem} | sed -e 's|^/\([a-zA-Z]\)/\+|\1:\\|')\" "
        done

        # Return the converted command by printing it to standard output.
        echo ${new_cmd}
    }

    # Runs a native windows command from within Git Bash in the same command window, ensuring smooth interoperability.
    function run-windows-cmd
    {
        # Convert the command and its arguments to Windows style.
        local cmd=("${@}")
        local new_cmd="$(convert-git-bash-cmd "${cmd[@]}")"

        # Run the command in the same window
        cmd.exe /C "${new_cmd}"
    }

    # Starts a native Windows program from within Git Bash in a separate window, ensuring smooth interoperability.
    function start-windows-cmd
    {
        # Convert the command and its arguments to Windows style.
        local cmd=("${@}")
        local new_cmd="$(convert-git-bash-cmd "${cmd[@]}")"

        # Run the command in a separate command window because Git Bash also does not have a good PTY interface. The K
        # switch is used so that the command prompt window stays open after the command completes.
        cmd.exe /C "start cmd.exe /K ${new_cmd}"
    }
fi

#-----------------------------------------------------------------------------------------------------------------------
# Common Windows Settings
#-----------------------------------------------------------------------------------------------------------------------

# Set common settings if Bash is running under a Windows-based shell (either WSL or Git Bash).
if [[ ${SHELL_IS_WSL_BASH} -eq 0 || ${SHELL_IS_GIT_BASH} -eq 0 ]]; then

    # Add in paths to common Windows binaries.
    export PATH="${C_DRIVE}/Windows/System32/:${PATH}"
    export PATH="${C_DRIVE}/Windows/System32/WindowsPowerShell/v1.0:${PATH}"

    # Setup aliases for common Windows commands. The cmd-start alias runs the command in a new window.
    alias cmd='run-windows-cmd cmd.exe'
    alias cmd-start='start-windows-cmd cmd.exe'
    alias start='run-windows-cmd start'
    alias powershell='run-windows-cmd powershell.exe'
    alias powershell-start='start-windows-cmd powershell.exe -NoExit'

    # Alias for the Mklink command. Note that symbolic links created with Mklink are usual able both by the WSL and
    # Windows. However, links created with ln appear as junctions to Windows, and thus aren't usable.
    alias mklink='run-windows-cmd mklink'
fi

#-----------------------------------------------------------------------------------------------------------------------
# Local Machine-Specific Settings
#-----------------------------------------------------------------------------------------------------------------------

# Source any local, machine-specific settings if there is a Bashrc file for it.
if [[ -f "${HOME}/.bashrc_local" ]]; then
    source "${HOME}/.bashrc_local"
fi
