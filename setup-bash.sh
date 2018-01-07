#!/bin/bash
#==============================================================================
# File:         setup-bash.sh
# Usage:        setup-bash.sh [-i|-u]
# Description:  Install bash config file.
#==============================================================================

source common-functions.sh

BASHRC="$HOME/.bashrc"

#------------------------------------------------------------------------------
# Main program
#------------------------------------------------------------------------------

if [ "$1" != "-i" -a "$1" != "-u" ]; then
    echo "Usage: $0 [-i|-u]"
    echo "  -i: installs bash configuration"
    echo "  -u: uninstalls bash configuration and restores the previous one"
    exit 1
fi

if [ "$1" == "-i" ]; then
    echo "Checking bash config already installed..."
    check_if_already_backed_up $BASHRC || \
        { echo "Aborting installation..."; exit 1; }

    echo "Checking needed packages..."
    check_and_install_packages bash

    echo "Backing up your files..."
    do_backup $BASHRC || \
        { echo "Aborting installation..."; exit 1; }

    echo "Installing config files..."
    do_install $BASHRC

    echo "Done!"
else
    echo "Restoring previous config..."
    do_restore $BASHRC || \
        { echo "Aborting restoration..."; exit 1; }
fi

exit 0
