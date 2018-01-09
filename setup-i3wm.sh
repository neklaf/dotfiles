#!/bin/bash
#==============================================================================
# File:         setup-i3wm.sh
# Usage:        setup-i3wm.sh [-i|-u]
# Description:  Install i3 Window Manager config file.
#==============================================================================

source common-functions.sh

I3WM_FOLDER="$HOME/.i3"
CONKYRC="$HOME/.conkyrc"
XINITRC="$HOME/.xinitrc"
I3STATUSCONF="$HOME/.i3status.conf"

#------------------------------------------------------------------------------
# Main program
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Notes (07/01/2018): create a symbolic link to bin directory
# $ ln -s $HOME/.local/bin bin
# It depends on some scripts located in $HOME/bin
#------------------------------------------------------------------------------

if [ "$1" != "-i" -a "$1" != "-u" ]; then
    echo "Usage: $0 [-i|-u]"
    echo "  -i: installs i3wm configuration"
    echo "  -u: uninstalls i3wm configuration and restores the previous one"
    exit 1
fi

if [ "$1" == "-i" ]; then
    echo "Checking i3wm config already installed..."
    check_if_already_backed_up $I3STATUSCONF $CONKYRC $XINITRC $I3WM_FOLDER || \
        { echo "Aborting installation..."; exit 1; }

    echo "Checking needed packages..."
    check_and_install_packages i3-wm feh conky thunar dunst dmenu i3lock xbacklight scrot

    echo "Backing up your files..."
    do_backup $I3STATUSCONF $CONKYRC $XINITRC $I3WM_FOLDER || \
        { echo "Aborting installation..."; exit 1; }

    echo "Installing config files..."
    do_install $I3STATUSCONF $CONKYRC $XINITRC $I3WM_FOLDER

    echo "Done!"
else
    echo "Restoring previous config..."
    do_restore $I3STATUSCONF $CONKYRC $XINITRC $I3WM_FOLDER || \
        { echo "Aborting restoration..."; exit 1; }
fi

exit 0
