#!/bin/bash
#==============================================================================
# File:         setup-git.sh
# Usage:        setup-git.sh [-i|-u]
# Description:  Install the tools and files needed to use git repos.
#==============================================================================

source common-functions.sh

GITCONFIG="$HOME/.gitconfig"

#------------------------------------------------------------------------------
# Main program
#------------------------------------------------------------------------------

if [ "$1" != "-i" -a "$1" != "-u" ]; then
    echo "Usage: $0 [-i|-u]"
    echo "  -i: installs the environment to work with git"
    echo "  -u: uninstalls the environment previously installed."
    exit 1
fi

if [ "$1" == "-i" ]; then
    echo "Checking git config already installed..."
    check_if_already_backed_up $GITCONFIG || \
        { echo "Aborting installation..."; exit 1; }

    echo "Checking needed packages..."
    check_and_install_packages git-core

    echo "Backing up your files..."
    do_backup $GITCONFIG || \
        { echo "Aborting installation..."; exit 1; }

    echo "Installing config files..."
    do_install $GITCONFIG
 
    echo "Setting up your git global info..."

    read -p "Enter your name (firstname secondname): " name
    git config --global user.name "$name"

    read -p "Enter your e-mail address: " email
    git config --global user.email "$email"

    echo "Done!"
else
    echo "Restoring previous config..."
    do_restore $GITCONFIG || \
        { echo "Aborting restoration..."; exit 1; }
fi

exit 0

