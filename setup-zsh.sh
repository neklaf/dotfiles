#!/bin/bash
#==============================================================================
# File:         setup-zsh.sh
# Usage:        setup-zsh.sh [-i|-u]
# Description:  Install bash config file.
#==============================================================================

source common-functions.sh

ZSHRC="$HOME/.zshrc"

#------------------------------------------------------------------------------
# Main program
#------------------------------------------------------------------------------

if [ "$1" != "-i" -a "$1" != "-u" ]; then
    echo "Usage: $0 [-i|-u]"
    echo "  -i: installs zsh configuration"
    echo "  -u: uninstalls zsh configuration and restores the previous one"
    exit 1
fi

if [ "$1" == "-i" ]; then
    echo "Checking bash config already installed..."
    check_if_already_backed_up $ZSHRC || \
        { echo "Aborting installation..."; exit 1; }

    echo "Checking needed packages..."
    check_and_install_packages zsh

    echo "Backing up your files..."
    do_backup $ZSHRC || \
        { echo "Aborting installation..."; exit 1; }

    echo "Installing config files..."
    do_install $ZSHRC

    echo "Done!"
else
    echo "Restoring previous config..."
    do_restore $ZSHRC || \
        { echo "Aborting restoration..."; exit 1; }
fi

exit 0
