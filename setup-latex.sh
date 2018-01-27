#!/bin/bash
#==============================================================================
# File:         setup-latex.sh
# Usage:        setup-latex.sh [-i|-u]
# Description:  Install the tools and files needed to use LaTeX.
#==============================================================================

source common-functions.sh

# Just a helper directory to installation process, not really needed
LATEXCONFIG=$HOME/.config/latex

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
    echo "Checking LaTeX config already installed..."
    check_if_already_backed_up $LATEXCONFIG || \
        { echo "Aborting installation..."; exit 1; }

    echo "Checking needed packages..."
    check_and_install_packages texlive-base texlive-binaries texlive-latex-base texlive-fonts-extra latex-xft-fonts texlive-latex-extra texlive-latex-extra texlive-lang-spanish

    echo "Backing up your files..."
    do_backup $LATEXCONFIG || \
        { echo "Aborting installation..."; exit 1; }

    echo "Installing config files..."
    do_install $LATEXCONFIG
 
    echo "Done!"
else
    echo "Restoring previous config..."
    do_restore $LATEXCONFIG || \
        { echo "Aborting restoration..."; exit 1; }
fi

exit 0
