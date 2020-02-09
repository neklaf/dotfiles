#!/bin/bash
#==============================================================================
# File:         setup-vim.sh
# Usage:        setup-vim.sh [-i|-u]
# Description:  Install vim config file.
#==============================================================================

source common-functions.sh

VIMRC="$HOME/.vimrc"
VIMFOLDER="$HOME/.vim"
LOCAL_VIMRC="./vim/vimrc"

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
    declare -A CONFIG_MAP=( ["$LOCAL_VIMRC"]="$VIMRC" )
    #printf "keys: ${!CONFIG_MAP[@]}\n"
    #printf "values: ${CONFIG_MAP[*]}\n"
    do_map_install "$(declare -p CONFIG_MAP)" 
    
    echo "Installing VIM plugins..."
    git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
    git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

    echo "Installing packages..."
    vim +PluginInstall +qall

    echo "Done!"
else
    echo "Restoring previous config..."
    do_restore $VIMRC $VIMFOLDER || \
        { echo "Aborting restoration..."; exit 1; }
fi

exit 0

