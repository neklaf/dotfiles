#!/bin/bash
#==============================================================================
# File:         setup-vim.sh
# Usage:        setup-vim.sh [-i|-u]
# Description:  Install vim config file.
#==============================================================================

source common-functions.sh

VIMRC="$HOME/.vimrc"
VIMFOLDER="$HOME/.vim"

#------------------------------------------------------------------------------
# Main program
#------------------------------------------------------------------------------

if [ "$1" != "-i" -a "$1" != "-u" ]; then
    echo "Usage: $0 [-i|-u]"
    echo "  -i: installs vim configuration"
    echo "  -u: uninstalls vim configuration and restores the previous one"
    exit 1
fi

if [ "$1" == "-i" ]; then
    echo "Checking vim config already installed..."
    check_if_already_backed_up $VIMRC $VIMFOLDER || \
        { echo "Aborting installation..."; exit 1; }

    echo "Checking needed packages..."
    check_and_install_packages vim ack-grep exuberant-ctags

    echo "Backing up your files..."
    do_backup $VIMRC $VIMFOLDER || \
        { echo "Aborting installation..."; exit 1; }

    echo "Installing config files..."
    do_install $VIMRC
    
    echo "Installing vundle..."
    git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

    echo "Installing vundle packages..."
    vim +PluginInstall +qall

    echo "Done!"
else
    echo "Restoring previous config..."
    do_restore $VIMRC $VIMFOLDER || \
        { echo "Aborting restoration..."; exit 1; }
fi

exit 0

