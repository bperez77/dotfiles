#-----------------------------------------------------------------------------------------------------------------------
#
# Bash Runcom/Run Commands (RC) File
#
# Author:           Brandon Perez <bmperez@alumni.cmu.edu>
# Creation Date:    Monday, May 29, 2012 at 10:45:40 AM EDT
#
# This file is executed when a BASH shell is started up, and sets the settings, command aliases, and environment
# variables for the shell session
#
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
# Files to Execute (Default Values)
#----------------------------------------------------------------------------------------------------------------------

# If this shell session is non-interactive, then don't run the Bashrc. Relevant environment variables should be
# inherited from the parent process.
if [ -z "$PS1" ]; then
    return
fi

# Source the system-wide defaults if there is a Bashrc for it.
if [ -f '/etc/bashrc' ]; then
    source '/etc/bashrc'
fi

# Source any aliases that are defined in a separate file.
if [ -f "${HOME}/.bash_aliases" ]; then
    source "${HOME}/.bash_aliases"
fi

# If the current shell is a POSIX shell, source the system-wide defaults for tab-completion for commands.
if [ -f '/etc/bash_completion' ] && (! shopt -oq posix); then
    source '/etc/bash_completion'
fi

#-----------------------------------------------------------------------------------------------------------------------
# History and Shell Options
#-----------------------------------------------------------------------------------------------------------------------

# Make the size of in-memory history of the current session unlimited.
export HISTSIZE=-1

# Make the size of the shared history stored in the history file unlimited.
export HISTFILESIZE==-1

# When adding new entries to the history, erase any duplicate values. Also, ignore any new entries that are a duplicate.
export HISTCONTROL="erasedups:ignoredups"

# Create the list of commands to ignore when they are used without any arguments (including options without arguments).
IGNORED_NOARG_COMMANDS=(python make ls ll dir cd 'git log' 'git clean' 'git status' 'git pull' 'git diff')
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

# Set the list of commands to ignore for new history entries, focusing on the items described above.
export HISTIGNORE="${HISTIGNORE}:${IGNORED_COMMANDS}"

# Set the format of the timestamps used in the history file.
export HISTTIMEFORMAT='%D:%T'

# Add to the command that is run before a new prompt is printed to the terminal to append the current history to the
# global history file. This ensures that new command windows will immediately have the history from other ones.
export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"

# When executing a pipeline of commands, the exit code of the pipeline is from rightmost command to exit with a non-zero
# exit status, or 0 if all commands are successful. Normally, the exit code simply comes from the last command.
set -o pipefail

# Append to the history file on exit, rather than overwriting it. This ensures that the history is saved across
# multiple sessions of the shell.
shopt -s cmdhist

# Save any multi-line commands to the history file as a single entry, so it can be easily recalled and used again.
shopt -s histappend

# Check the window size after each command, and adjust the text as necessary (for window resizes).
shopt -s checkwinsize

# Enable tab completion of hostnames from the /etc/hosts file, after an '@' character.
shopt -s hostcomplete

# Allow for the extended globbing patterns for the command-line, which allow for lists of glob patterns to be used.
shopt -s extglob

# Allow for the recursive '**' glob pattern, which matches to 0 or more subdirectories (in a file expansion context).
shopt -s globstar

# Fix simple spelling errors when using the change directory command.
shopt -s cdspell

# Fix simple spelling errors when using tab completion on directories.
shopt -s dirspell

#-----------------------------------------------------------------------------------------------------------------------
# Bash Command-Line Prompt
#-----------------------------------------------------------------------------------------------------------------------

# ANSI color and modifications codes for terminal text
CYAN=$(tput setaf 6)    # Cyan color for text
GREEN=$(tput setaf 2)   # Green color for text (foreground color)
NORMAL=$(tput sgr0)     # Return text to normal
YELLOW=$(tput setaf 3)  # Yellow color for text

# Set the terminal prompt. The current user is represented by \u, host by \h, and the current working directory by \w.
PS1="${GREEN}[\\u@\\h ${YELLOW}\\w${CYAN}\$(__git_ps1)${GREEN}]\\\$ ${NORMAL}"

#-----------------------------------------------------------------------------------------------------------------------
# General Environment Variables
#-----------------------------------------------------------------------------------------------------------------------

# The startup file to use before running Python. This enables persistent Python command history and tab completion.
export PYTHONSTARTUP="${HOME}/.pythonstartup"

# Add locally installed Go programs for the user to the list of paths for Go programs and their binaries.
export GOPATH="${GOPATH}:${HOME}/.go"

# A good heuristic for the number of threads to use when compiling code in parallel (especially with Makefiles).
export THRS=$((2 * $(getconf _NPROCESSORS_ONLN)))

#-----------------------------------------------------------------------------------------------------------------------
# Paths
#-----------------------------------------------------------------------------------------------------------------------

# Add the bin directory to the path, where any miscellaneous executables may be.
export PATH="${PATH}:${HOME}/bin/"

# Add the paths for the installed Arduino studio, MATLAB, Altera Quartus, and Eagle programs to the path
export PATH="${PATH}:/usr/bin/Arduino/arduino"
export PATH="${PATH}:/usr/local/MATLAB/R2015a/bin/"
export PATH="${PATH}:/opt/Altera/15.1/quartus/bin/"
export PATH="${PATH}:/opt/eagle-7.5.0/bin/"

# Add the various Xilinx tools (Vivado, HLS, SDK, cross-compiler) to the path.
XILINX_ROOT='/opt/Xilinx/'
XILINX_VERSION='2017.2'
export PATH="${PATH}:${XILINX_ROOT}/Vivado/${XILINX_VERSION}/bin/"
export PATH="${PATH}:${XILINX_ROOT}/SDK/${XILINX_VERSION}/gnu/arm/lin/bin/"
export PATH="${PATH}:${XILINX_ROOT}/SDK/${XILINX_VERSION}/bin/"
export PATH="${PATH}:${XILINX_ROOT}/Vivado_HLS/${XILINX_VERSION}/bin/"

# Add the programs for the Go language and any installed Go programs to the path.
export PATH="${PATH}:${GOPATH}/bin"

# Add the programs for the manually installed C0 and SML/NJ languages to the path.
export PATH="${PATH}:/usr/share/smlnj/bin/"
export PATH="${PATH}:/usr/share/cc0/bin/"

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
alias pylint-dbg='python -m pylint --reports=no --disable=C,R'
alias pylint3-dbg='python3 -m pylint --reports=no --disable=C,R'

# Aliases for running Makefiles to cross-compile C/C++ code for ARM and Android.
alias make-arm='make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-'
alias make-android='make ARCH=arm CROSS_COMPILE=arm-linux-androideabi-'

# Setup the tag generation command to recursively traverse all subdirectories, use class/hierarchy qualified tags to
# resolve naming conflicts, include class inheritance information for fields, and use the line number to identify
# declaration instead of patterns to make it robust against source code changes.
alias ctags='ctags --recurse --extras=+q --fields=+i --excmd=number'

# Changes directory to the top-level/root of the current Git repository
alias git-root='cd $(git rev-parse --show-cdup)'

# Setup the LaTeX compilation commands to be compatible with the Minted and Pygments syntax highlighters by default.
alias pdflatex='pdflatex -shell-escape'
alias latex='latex -shell-escape'

# Setup the readline wrapper so that it maintains a large history, doesn't repeat duplicates, and handles ANSI color
# codes by default.
alias rlwrap='rlwrap --always-readline --histsize 1000000 --history-no-dupes 2 --ansi-colour-aware'

# Create aliases for commands that wraps them with the readline library. This is useful for commands that utilize a
# REPL, but do not provide readline functionality. This will give the commands persistent history and tab completion.
RLWRAP_COMMANDS=(lua smlnj coin sim240)
for cmd in "${RLWRAP_COMMANDS[@]}"
do
    eval "alias ${cmd}='rlwrap --history-filename \"${HOME}/.$(basename ${cmd})_history\" ${cmd}'"
done

# Matlab does not cooperate well with disowning, so simply launch the command with its output redirected.
function matlab
{
    matlab "$@" &> /dev/null &
}

# Runs the command-line (no GUI) version of Matlab.
alias matlab-shell='command matlab -nodisplay'

#-----------------------------------------------------------------------------------------------------------------------
# General Aliases
#-----------------------------------------------------------------------------------------------------------------------

# Allow aliases to be used with the sudo command. This is done by adding a space at the end of the alias.
alias sudo='sudo '

# Setup the ls and various grep commands to use color highlighting by default.
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

# Setup a shorter alias for Vim, and setup an alias for Emacs to open in the terminal, instead of a GUI window.
alias vi='vim'
alias emacs='emacs24 --no-window-system'

# Setup the dd command to show progress of the data movement by default.
alias dd='dd status=progress'

# Setup the dmesg command so that the kernel log messages have human-readable timestamps by default.
alias dmesg='dmesg --ctime --color=always'

# Setup the remote sync command to preserve file metadata, show incremental progress, and exclude files by default.
RSYNC_EXCLUDED_FILES=('.*.swp' '*.o' '*~' '*.pyc' '__pycache__')
RSYNC_EXCLUDE=("${RSYNC_EXCLUDED_FILES[@]/#/--exclude }")
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
    nargs=${#}
    if [ ${nargs} -eq 0 ]; then
        echo 'Error: No text files specified.'
        echo 'Usage: $(basename ${0}) <text_file1> [text_file2 text_file3 ...]'
        return 1
    fi

    text_files=("${@}")
    for text_file in "${text_files[@]}"
    do
        vim -c ':retab' -c 'set ff=unix' -c ':wq' ${text_file}
    done
}

# Runs an arbitrary command and sends a desktop notification (Ubuntu only) when the command finishes. The message also
# reports the exit status of the command that was run.
function notify-complete
{
    # Check that the proper number of command line arguments was specified.
    local nargs=$#
    if [ ${nargs} -eq 0 ]; then
        echo 'Error: No command specified.'
        echo 'Usage: notify <cmd> [cmd_arg1 cmd_arg2 ...]'
        return 1
    fi

    # Get the name of the command (without the path) and the full command.
    local cmd_name=$(basename ${1})
    local cmd="${@}"

    # Run the command to completion, and then send a desktop notification when it finishes.
    ${cmd}
    notify-send "The command '${cmd_name}' has finished with exit status '${?}'."
}

# Changes the root directory and binds parts of the original root file system to the faked root filesystem, and unmount
# them when done (it is very important that they are unmounted). This provides common kernel pseudofiles, and gives an
# environment comparable to a virtual machine when combined with the QEMU static binary.
function chroot-full
{
    # Check that the user has specified the proper number of command line arguments.
    local num_args=${#}
    if [ ${num_args} -ne 1 ]; then
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

    # Unmount all of the binded mount points from the faked root filesystem.
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
    eval "function $cmd {
        nohup $cmd \"\$@\" &> /dev/null &
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
    if [ $nargs -ne 1 ]; then
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
# Xilinx Tool Aliases
#-----------------------------------------------------------------------------------------------------------------------

# The (typical) IP addresses for this machine and the Zedboard when connected over Ethernet with network sharing.
export HOST_IP_ADDR=10.42.0.1
export ZYNQ_IP_ADDR=10.42.0.196

# Aliases for connecting to a Xilinx Zynq device shell over UART (via USB) and over SSH (via Ethernet).
alias zynq-console='sudo minicom --device /dev/ttyACM0'
alias zynq-ssh="ssh root@${ZYNQ_IP_ADDR}"

# Synchronizes against an outstanding file writes and then unmounts the SD card with the boot image and root filesystem.
alias boot-umount='sync && umount /media/bmperez/boot /media/bmperez/rootfs'

# Flashes a Zynq device's FPGA with a new hardware image (bit file) over a local Ethernet connection.
function zynq-remote-flash
{
    nargs=${#}
    if [ ${nargs} -lt 1 -o ${nargs} -gt 2 ]; then
        echo 'Error: Improper number of command line arguments specified.'
        echo 'Usage: zynq-remote-flash <bit_image_file> [zynq_ip_addr]'
        return 1
    fi

    # Get the values of the arguments
    bit_image_file="${1}"
    if [ ${nargs} -eq 2 ]; then
        zynq_ip_addr="${2}"
    else
        zynq_ip_addr=${ZYNQ_IP_ADDR}
    fi

    scp "${bit_image_file}" root@"${zynq_ip_addr}":/dev/xdevcfg
}

# Create functions for the Xilinx tools that runs them as GUI commands. Also, launch the commands  in a temporary
# directory so the log files do not clutter the current working directory, as these tools generate a lot of them.
VIVADO_LOG_DIR='/tmp/'
VIVADO_COMMANDS=(vivado xsdk vivado_hls)
for cmd in "${VIVADO_COMMANDS[@]}"
do
    eval "function ${cmd} {
        cd '${VIVADO_LOG_DIR}'
        nohup ${cmd} \"${@}\" &> /dev/null &
        cd - &> /dev/null
    }"
done

#-----------------------------------------------------------------------------------------------------------------------
# Windows Subsystem for Linux (WSL) Settings
#-----------------------------------------------------------------------------------------------------------------------

# Determine if the shell is being run under Microsoft's Windows Subsystem for Linux (WSL)
if (grep --quiet --regexp='\<Microsoft\>' --regexp='\<WSL\>' '/proc/version'); then

    # Change the ls colors so that other-writable directories will not be highlighted in green, and instead appear as
    # normal directories. This is done because files on the Windows drives will not have proper permissions.
    eval $(dircolors -b)
    export LS_COLORS="${LS_COLORS}:ow=01;34"

    # Set the display variable to the localhost so Xming can be used with X11-forwarding to display GUI applications.
    export DISPLAY='localhost:0'

    # The location where the C drive is mounted in the WSL.
    export C_DRIVE='/mnt/c/'

    # The location of the Window User's home directory in the WSL (assumes that the usernames match).
    export WINDOWS_HOME="${C_DRIVE}/Users/${USER}"

    # Add in paths to common Windows binaries.
    export PATH="${PATH}:${C_DRIVE}/Windows/System32/"
    export PATH="${PATH}:${C_DRIVE}/Windows/System32/WindowsPowerShell/v1.0"

    # Runs a native Windows command/binary from within the WSL, and performs some steps for sane execution. This
    # includes converting any drive paths to their Windows drive letter (e.g. /mnt/c to C:) and starting the command in
    # a new command window. These are done to handle idiosyncrasies of running in the WSL.
    function run-windows
    {
        cmd=("${@}")

        # Replace drive paths in each element of the command with the Windows drive letter, making sure to preserve
        # spaces that are embedded in arguments.
        new_cmd=()
        for elem in "${cmd[@]}"
        do
            new_cmd+=("$(echo ${elem} | sed -e 's|/mnt/\([a-zA-Z]\)/*|\1:\\|g')")
        done

        # Run the command in a separate command window.
        cmd.exe /C start cmd.exe /K "${new_cmd[@]}"
    }

    # Setup alias for common Windows commands. These call the run Windows function to invoke them.
    alias start='run-windows'
    WINDOWS_COMMAND_ALIASES=(cmd powershell msbuild vsmsbuild quickbuild pacman build drop)
    WINDOWS_COMMANDS=(cmd.exe 'powershell.exe -NoExit' msbuild vsmsbuild quickbuild pacman build drop.exe)
    for ((i=0; i < ${#WINDOWS_COMMAND_ALIASES[@]}; i++))
    do
        eval "alias ${WINDOWS_COMMAND_ALIASES[$i]}='run-windows ${WINDOWS_COMMANDS[$i]}'"
    done
fi

#-----------------------------------------------------------------------------------------------------------------------
# Local Machine-Specific Settings
#----------------------------------------------------------------------------------------------------------------------

# Source any local, machine-specific settings if there is a Bashrc file for it.
if [ -f "${HOME}/.bashrc_local" ]; then
    source "${HOME}/.bashrc_local"
fi
