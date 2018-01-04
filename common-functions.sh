#!/bin/bash
#==============================================================================
# File:         common-functions.sh
# Usage:        ----
# Description:  Common functions used in setup scripts.
#==============================================================================

FILE_EXT=".bck"
FOLDER_EXT="_bck"

#=== FUNCTION =================================================================
# Name:         check_and_install_packages
# Description:  Checks if a list of packages are installed and installs those
#                   that are not installed.
# Param 1:      package name
#==============================================================================
function check_and_install_packages() {
    for pkg in "$@"; do
        echo "Checking $pkg package..."
        dpkg -s $pkg > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "Package $pkg not present. Installing..."
            sudo apt-get install $pkg
        fi
    done
}

#=== FUNCTION =================================================================
# Name:         check_if_already_backed_up
# Description:  check if any of the params has been already backed up.
# Param n:      file or folder full path 
#==============================================================================
function check_if_already_backed_up() {
    for element in "$@"; do
        if [ -f "${element}$FILE_EXT" -o -d "${element}$FOLDER_EXT" ]; then
            echo "Previous backup found for '$element'"
            return 1
        fi
    done
    return 0
}

#=== FUNCTION =================================================================
# Name:         do_backup
# Description:  backups a list of files and/or folders
# Param n:      file or folder full path 
#==============================================================================
function do_backup() {
    for element in "$@"; do
        if [ -f "$element" ]; then
            dst_file="${element}$FILE_EXT"
            echo "Moving file '$element' -> '$dst_file'"
            mv --no-clobber $element $dst_file || \
                { echo "Error $? moving file '$element'"; return 1; }
        elif [ -d "$element" ]; then
            dst_folder="${element}$FOLDER_EXT"        
            echo "Moving folder '$element' -> '$dst_folder'"
            mv --no-clobber --no-target-directory $element $dst_folder || \
                { echo "Error $? moving folder '$element'"; return 1; }
        fi
    done
    return 0
}

#=== FUNCTION =================================================================
# Name:         do_restore
# Description:  restores a list of files and/or folders
# Param n:      file or folder full path 
#==============================================================================
function do_restore() {
    for element in "$@"; do
        backup_file_path="${element}$FILE_EXT"
        backup_folder_path="${element}$FOLDER_EXT"
        if [ -f "$backup_file_path" ]; then
            echo "Restoring file: $backup_file_path -> $element"
            mv $backup_file_path $element
        elif [ -d "$backup_folder_path" ]; then
            echo "Restoring folder: $backup_folder_path -> $element"
            rsync --archive --delete "${backup_folder_path}/" $element || \
                { echo "Error: restoring '$backup_folder_path'"; return 1; }
            rm --recursive --force $backup_folder_path || \
                { echo "Warning: restoring '$backup_folder_path'"; return 1; }
        else
            echo "Error: No backup for '$element'"
            return 1
        fi
    done
    return 0
}

#=== FUNCTION =================================================================
# Name:         do_install
# Description:  installs a list of files and/or folders
# Notes:        Only works with folders and files starting with "."
#               The file/folder must exist in the current path without the
#                   starting dot.
# Param n:      file or folder full path 
#==============================================================================
function do_install() {
    for element in "$@"; do
        src_name=${element##*/}
        src_name=${src_name##.}
        if [ -f "$src_name" ]; then
            echo "Installing file '$src_name' -> $element"
            cp --no-clobber --preserve $src_name $element
        elif [ -d "$src_name" ]; then
            echo "Installing folder '$src_name' -> $element"
            cp --recursive --no-clobber --preserve --no-target-directory $src_name $element
        fi
    done
}

