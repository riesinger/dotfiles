#!/usr/bin/env zsh

# Created by Pascal "Arial7" Riesinger
# Licensed under MIT license. Feel free to copy these files and base your own
# dotfiles on mine.

# This scripts checks various files to try and detect the current distro
# if it fails to do this, it will just ask the user to input the distro's name

CURRENT_DISTRIBUTION=""

function read_release_files() {
    local rls="$(grep 'DISTRIB_ID' /etc/lsb-release | cut -d'=' -f 2-)"
    printf "%s" "$rls"
}

main() {
    local autodetected=$(read_release_files)
    if [ -z "$autodetected" ]; then
        printf "Could not detect distro\n"
        printf "What are you running on?"
        read distro
    else
        printf "You are runnning %s. Is this correct? [Y/n] " "$autodetected"
        read answer
        case "$answer" in
            'N'|'n') printf "Which distro are you running? "; read distro ;;
            *) distro=$autodetected ;;
        esac
    fi

    CURRENT_DISTRIBUTION="$(echo $distro | tr '[:upper:]' '[:lower:]')"
}

main "$@"
