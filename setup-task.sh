#!/bin/bash
#==============================================================================
# File:         setup-vim.sh
# Usage:        setup-vim.sh [-i|-u]
# Description:  Install vim config file.
#==============================================================================

source common-functions.sh

TASKRC="$HOME/.taskrc"
TIMEFOLDER="$HOME/.timewarrior"
TIMERC="$HOME/.timewarrior/timewarrior.cfg"
LOCAL_TASKRC="task/taskrc"
LOCAL_TIMERC="task/timewarrior.cfg"

#------------------------------------------------------------------------------
# Main program
#------------------------------------------------------------------------------

install() {
    echo "Checking vim config already installed..."
    check_if_already_backed_up $TASKRC $TIMEFOLDER $TIMERC || \
        { echo "Aborting installation..."; exit 1; }

    echo "Checking needed packages..."
    check_and_install_packages taskwarrior timewarrior

    echo "Backing up your files..."
    do_backup $TASKRC $TIMEFOLDER $TIMERC || \
        { echo "Aborting installation..."; exit 1; }

    echo "Installing config files..."
    declare -A CONFIG_MAP=( ["$LOCAL_TASKRC"]="$TASKRC", ["$LOCAL_TIMERC"]="$TIMERC" )
    do_map_install "$(declare -p CONFIG_MAP)" 
}

uninstall() {
    echo "Restoring previous config..."
    do_restore $TASKRC $TIMEFOLDER $TIMERC || \
        { echo "Aborting restoration..."; exit 1; }
}

if [ "$1" != "-i" -a "$1" != "-u" ]; then
    echo "Usage: $0 [-i|-u]"
    echo "  -i: installs vim configuration"
    echo "  -u: uninstalls vim configuration and restores the previous one"
    exit 1
fi

if [ "$1" == "-i" ]; then
    install   
    echo "Done!"
else
    uninstall
fi

exit 0

