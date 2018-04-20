#-----------------------------------------------------------------------------------------------------------------------
#
# Bash Runcom/Run Commands File
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
if [ -f /etc/bashrc ]; then
    source  /etc/bashrc
fi

# Source any aliases that are defined in a separate file.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# If the current shell is a POSIX shell, source the system-wide defaults for tab-completion for commands.
if [ -f /etc/bash_completion ] && (! shopt -oq posix); then
    source /etc/bash_completion
fi

#-----------------------------------------------------------------------------------------------------------------------
# History and Shell Options
#-----------------------------------------------------------------------------------------------------------------------

# Make the size of in-memory history of the current session unlimited.
export HISTSIZE=

# Make the size of the shared history stored in the history file unlimited.
export HISTFILESIZE=

# When adding new entries to the history, erase any duplicate values. Also, ignore any new entries that are a duplicate,
# and ignore any commands beginning with whitespace (both).
export HISTCONTROL="erasedups:ignoreboth"

# Set the list of commands to ignore as new history entries.
export HISTIGNORE='ls:bg:fg:exit:history:man'

# Set the format of the timestamps used in the history file.
export HISTTIMEFORMAT='%D:%T'

# Update the command that is run before a new prompt is printed to the command to append the current history to the
# shared history file.
export PROMPT_COMMAND="${PROMPT_COMMAND}; history -a"

# Tells the shell to append to the history file on exit, rather than overwriting it. This ensures that the history is
# saved across multiple sessions of the shell.
shopt -s cmdhist

# Tells the shell to save any multi-line commands to the history as a single entry, so it can be easily used again.
shopt -s histappend

# Tell Bash to check the window size after each command, and adjust the text as necessary (for window resizes).
shopt -s checkwinsize

# Enable tab completion of hostnames from the /etc/hosts file, after an '@' symbol.
shopt -s hostcomplete

# Allow for the extended globbing patterns for the command-line, which allow for lists of glob patterns to be used.
shopt -s extglob

# Allow for the recursive '**' glob pattern, which matches to 0 or more subdirectories (in a file expansion context).
shopt -s globstar

# Fix simple spelling errors when using the `cd` command.
shopt -s cdspell

# Fix simple spelling errors when using tab completion on directories.
shopt -s dirspell

#-----------------------------------------------------------------------------------------------------------------------
# Bash Command-Line Prompt
#-----------------------------------------------------------------------------------------------------------------------

# ANSI color and modifications codes for terminal text
CYAN="\[\033[36m\]"     # Cyan color for text
GREEN="\[\033[32m\]"    # Green color for text (foreground color)
NORMAL="\[\033[0m\]"    # Return text to normal
YELLOW="\[\033[33m\]"   # Yellow color for text

# Set the terminal prompt. The current user is represented by \u, host by \h, and the current working directory by \w.
PS1="${GREEN}"'[\u@\h '"${YELLOW}"'\w'"${CYAN}"'$(__git_ps1)'"${GREEN}]\\$ ${NORMAL}"

#-----------------------------------------------------------------------------------------------------------------------
# General Environment Variables
#-----------------------------------------------------------------------------------------------------------------------

# The startup file to use before running Python. This enables persistent Python command history and tab completion.
export PYTHONSTARTUP=${HOME}/.pythonstartup

export GOPATH=${HOME}/.go

# A good heuristic for the number of threads to use when compiling code in parallel (especially with Makefiles).
export THRS=$((2 * $(getconf _NPROCESSORS_ONLN)))

# IP addresses for this machine and the Zedboard when connected over Ethernet with network sharing.
export HOST_IPADDR=10.42.0.1
export BOARD_IPADDR=10.42.0.196

#-----------------------------------------------------------------------------------------------------------------------
# Paths
#-----------------------------------------------------------------------------------------------------------------------

# Add the programs for the manually installed C0 and SML/NJ languages to the path.
export PATH=${PATH}:/usr/share/smlnj/bin/
export PATH=${PATH}:/usr/share/cc0/bin/

# Add various manually installed code development programs to the path.
export PATH=${PATH}:/usr/bin/Arduino/arduino
export PATH=${PATH}:/usr/local/MATLAB/R2015a/bin/
export PATH=${PATH}:/opt/Altera/15.1/quartus/bin/
export PATH=${PATH}:/opt/eagle-7.5.0/bin/

# Add the various Xilinx tools to the path.
XILINX_ROOT=/opt/Xilinx/
XILINX_VERSION=2017.2
export PATH="${PATH}:${XILINX_ROOT}/Vivado/${XILINX_VERSION}/bin/"
export PATH="${PATH}:${XILINX_ROOT}/SDK/${XILINX_VERSION}/gnu/arm/lin/bin/"
export PATH="${PATH}:${XILINX_ROOT}/SDK/${XILINX_VERSION}/bin/"
export PATH="${PATH}:${XILINX_ROOT}/Vivado_HLS/${XILINX_VERSION}/bin/"

# Add the programs for the Go language and any installed Go programs to the path.
export PATH=${PATH}:${GOPATH}/bin

#-----------------------------------------------------------------------------------------------------------------------
# Aliases
#-----------------------------------------------------------------------------------------------------------------------

# Allow aliases to be used with the sudo command
alias sudo='sudo '

# Add color to commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add default options to common commands
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i -d --preserve=all'
alias dmesg='dmesg -T'

# Aliases for navigating up directories
alias ..='cd ..'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias ..6='cd ../../../../../../'
alias ..7='cd ../../../../../../../'
alias ..8='cd ../../../../../../../../'
alias ..9='cd ../../../../../../../../../'
alias ..10='cd ../../../../../../../../../../'

# Always SSH with X11 forwarding (windows opened on remote display locally)
alias ssh-x='ssh -X'

# Commands for working with a persistent SSH connection to a server
alias ssh-open='ssh -M -f -N -o ControlPath=${HOME}/.ssh/ssh-%r-%h-%p'
alias ssh-close='ssh -S ${HOME}/.ssh/ssh-%r-%h-%p -O exit'
alias rsync-per='rsync -e "ssh -o ControlPath=${HOME}/.ssh/ssh-%r-%h-%p"'
alias scp-per='scp -o ControlPath=${HOME}/.ssh/ssh-%r-%h-%p'

# Setup rsync to exclude generated files, and preserve file information.
# Also setup alises for tracking progress and mirroring directories
alias rsync='rsync -a --info=progress2 --exclude ".*.swp" --exclude "*.o" \
             --exclude "*~" --exclude "*.pyc" '
alias rsync-mirror='rsync --delete --delete-excluded '
alias rsync-progress='rsync --no-inc-recursive '

# Aliases for text editors
alias vi='vim'
alias emacs='emacs24 -nw'

# Show progress when copying data with dd
alias dd='dd status=progress '

# Safely remove a disk by its device name
alias safe-remove='udisksctl power-off -b'

# Download a file in parallel from a website, using multiple (16) connections
alias parallel-download='aria2c -x 16 -s 16'

# Aliases for using latex with minted and Pygments syntax highlighters
alias pdflatex='pdflatex -shell-escape'
alias latex='latex -shell-escape'

# Aliases for shutting down a computer in Wake on LAN mode, and waking up the computers
# from their Wake on LAN states
ETH_IFACE=$(ifconfig | grep '^e' | awk '{print $1}')
alias wol-poweroff="sudo ethtool -s ${ETH_IFACE} wol g && sudo poweroff"
alias homefs-wol="wakeonlan -i ${HOMEFS_IPADDR} ${HOMEFS_HWADDR}"
alias forty2-wol="wakeonlan -i ${FORTY2_IPADDR} ${FORTY2_HWADDR}"

# Mount commands for accessing files on the windows drive with a dual boot setup
alias mountwin='sudo mount -t ntfs /dev/sda2 /mnt/windows -o umask=022'
alias unmountwin='sudo umount /dev/sda2'

# Command for mounting the AFS volume
alias mount-afs='sudo service openafs-client start && kinit && aklog && aklog andrew.cmu.edu'

# Alias to run a python script with the python debugger (pdb)
alias python-pdb='python -m pdb'

# Enable command history for smlnj (15-150), C0 (15-122), P18240 Simulator
alias smlnj='rlwrap sml'
alias coin='rlwrap coin'
alias sim240='rlwrap sim240'

# Add safe and debugging aliases for gcc compilation
SAFE_FLAGS="-Wall -Werror -Wextra -std=gnu99"
DEBUG_FLAGS="${SAFE_FLAGS} -g -ggdb -O0"
alias gcc-safe="gcc ${SAFE_FLAGS}"
alias gcc-debug="gcc ${DEBUG_FLAGS}"
alias g++-safe="gcc ${SAFE_FLAGS}"
alias g++-debug="gcc ${DEBUG_FLAGS}"

# Add debug aliases for valgrind and pylint
alias vgd='valgrind --track-origins=yes --track-fds=yes --leak-check=full'
alias pylint-dbg='python $(which pylint) -r n --disable=C,R'
alias pylint3-dbg='python3 $(which pylint3) -r n --disable=C,R'

# Some cross-architecture targets
alias make-arm='make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-'
alias make-android='make ARCH=arm CROSS_COMPILE=arm-linux-androideabi-'

# An alias to connect to the board
alias zynq-console='sudo minicom -D /dev/ttyACM0'
alias zynq-ssh='ssh root@10.42.0.35'

# Alias to fetch all files under a directory on a website
alias wget-dir='wget -r -nH -nd -np -e robots=off '

# Alias to flash the FPGA with a new bit file (update the hardware)
function zynq-remote-flash
{
    scp $1 root@${BOARD_IPADDR}:/dev/xdevcfg
}

# Aliases to compile and copy components
alias flash-kern='cd ~/school/18545/kernels/xillinux/ &&
    make-xarm -j8 UIMAGE_LOADADDR=0x8000 uImage &&
    /bin/cp arch/arm/boot/uImage /media/bmperez/boot/uImage'
alias flash-dtb='cd ~/school/18545/kernels/xillinux/ && make-xarm dtbs &&
    /bin/cp arch/arm/boot/dts/zynq-zed.dtb /media/bmperez/boot/devicetree.dtb'
alias flash-modules='cd ~/school/18545/kernels/xillinux/ && make-xarm -j8 modules &&
    sudo env "PATH=$PATH" make ARCH=arm CROSS_COMPILE=arm-xilinx-linux-gnueabi- INSTALL_MOD_PATH=/media/bmperez/rootfs/ modules_install'
alias flash-modules-nfs='cd ~/school/18545/kernels/xillinux/ && make-xarm -j8 modules &&
    sudo env "PATH=$PATH" make ARCH=arm CROSS_COMPILE=arm-xilinx-linux-gnueabi- INSTALL_MOD_PATH=~/school/18545/filesystems/xillinux_core_fs/ modules_install'

# Alias to sync and unmount the SD boot card
alias bootumount='sync && umount /media/bmperez/boot /media/bmperez/rootfs'

# Restart Wifi (helps deal with poor/lost connections)
alias wifi-restart='sudo service network-manager restart'

# Formats a text file according to the preferred style
alias format-text-file='vim -c ":retab" -c "set ff=unix" -c ":wq"'

# Replace the Xilinx tools with aliases that place the logs in a directory
export VIVADO_LOG_DIR=/tmp/
function vivado {
    cd ${VIVADO_LOG_DIR}
    nohup $(which vivado) "$@" &> /dev/null &
    cd - &> /dev/null
}
function xsdk {
    cd ${VIVADO_LOG_DIR}
    nohup $(which xsdk) "$@" &> /dev/null &
    cd - &> /dev/null
}
function vivado_hls {
    cd ${VIVADO_LOG_DIR}
    # Don't use the latest GTK version, this causes HLS to crash
    SWT_GTK3=0 nohup $(which vivado_hls) "$@" &> /dev/null &
    cd - &> /dev/null
}

# A convenient command to send a desktop notification when a command finishes
function notify {
    nargs=$#
    if [ $# -eq 0 ]; then
        echo "Error: No command specified."
        echo "Usage: notify <cmd> [arg1 arg2 ...]"
        return 1
    fi
    cmd_name=$(basename $1)
    cmd="$@"

    $cmd
    notify-send "Command \`${cmd_name}\` has finished. Exit status was $?."
}

# Wrapper for chroot that gives you a complete kernel environment
function chroot-full {
    num_args=$#
    if [ $num_args -ne 1 ]; then
        echo "Error: Improper number of command line arguments"
        echo "Usage: chroot-full <corefs_path>"
        return
    fi

    fs_root=$1

    for mod in /sys /proc /dev /dev/pts /etc/resolv.conf
    do
        sudo mount -o bind $mod "$fs_root/$mod"
    done

    sudo LC_ALL=C chroot "$fs_root"

    for dev in /sys /proc /dev/pts /dev /etc/resolv.conf
    do
        sudo umount "$fs_root/$dev"
    done
}

# Mount commands to mount a google drive account as a folder in the user's home
function mount-gdrive {
    sudo mkdir -p /mnt/gdrive &&
    if [ ! -e ~/gdrive ]; then
        ln -s /mnt/gdrive ~/gdrive
    fi &&
    sudo google-drive-ocamlfuse -o default_permissions,allow_other,umask=022 \
        /mnt/gdrive
}
alias umount-gdrive='sudo fusermount -u /mnt/gdrive'

# Replaces commands with aliases that automatically run in the background
cmds=(evince quartus arduino vmware virtualbox libreoffice gimp \
      makerware kile qtspim spotify kicad gedit meld keepassx eclipse krop feh \
      picard)
for cmd in ${cmds[@]}
do
    eval "function $cmd { nohup $cmd \"\$@\" &> /dev/null & }"
done

# Automatically run feh in the background, and scale the image to the screen size
function feh {
    nohup $(which feh) --scale-down "$@" &> /dev/null &
}

# Matlab doesn't cooperate well with nohup, and an alias for the no GUI version
function matlab {
    $(which matlab) "$@" &> /dev/null &
}
alias matlab-shell="$(which matlab) -nodisplay"

# Function to render markdown in a browser tab
function markdown() {
    pandoc $@ | bcat
}

# Function to randomize the MAC address of the given device
function randomize-mac {
    if [ $# -ne 1 ]; then
        echo "Error: Improper number of command line arguments."
        echo "randomize-mac <device>"
        return 1
    fi

    device=$1
    sudo ifconfig $device down &&
    sudo macchanger -a ${device} &&
    sudo ifconfig $device up
}
