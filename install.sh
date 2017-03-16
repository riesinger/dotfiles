#!/bin/zsh

# Created by Pascal "Arial7" Riesinger
# Licensed under MIT license. Feel free to copy these files and base your own
# dotfiles on mine.

# This script will install all of the dotfiles, as well as provide a simple
# 'bootstrap' function wich will install my most commonly used programs and
# tools. Note that this is intended for Archlinux, so bootstraping does not
# work on other distros.


# This function will look for the dotfiles and link them, if they do not exist
# yet. Otherwise, the linking will be skipped.

ARCH_PACKAGE_LIST="neovim htop zsh lm_sensors noto-fonts termite tmux nodejs npm"
UBUNTU_PACKAGE_LIST="htop zsh lm_sensors nodejs npm tmux"
NODE_PACKAGE_LIST="vue-cli yarn mocha npm-check-updates"

LOGFILE="/tmp/bootstrap.log"

BOOTSTRAP_STATUS_COL="30"

bold=$(tput bold)
normal=$(tput sgr0)

source "$HOME/.dotfiles/scripts/detect_distro.sh"

function package_is_needed() {
    hash $1 > /dev/null 2>&1
    if [ $? '==' "0" ]; then
        return 1
    else
        return 0
    fi
}

function link_dotfiles() {
    echo "Installing dotfiles"

    DOTFILES=$HOME/.dotfiles

    echo -e "\nCreating symlinks"
    echo "=============================="
    linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
    printf "Files:\n"
    for file in $linkables ; do
        #printf "$file\t to \t"
        target="$HOME/.$( basename $file '.symlink' )"
        echo -e "$( basename $file '.symlink' )\t $file \n"
        #printf "$target\n"
        if [ -e $target ]; then
            echo "~${target#$HOME} already exists... Skipping."
        else
            echo "Creating symlink for $file"
            ln -s $file $target
        fi
    done

    echo -e "\n\nInstalling to ~/.config"
    echo "=============================="
    if [ ! -d $HOME/.config ]; then
        echo "Creating ~/.config"
        mkdir -p $HOME/.config
    fi
    for config in $DOTFILES/config/*; do
        target=$HOME/.config/$( basename $config )
        if [ -e $target ]; then
            echo "~${target#$HOME} already exists... Skipping."
        else
            echo "Creating symlink for $config"
            ln -s $config $target
        fi
    done


}

# This will install the my commonly used packages, fonts etc.
# Afterwards, it will start the link_dotfiles function.
function bootstrap() {
    [[ $UID -eq 0 ]] || printf "To bootstrap, you need to run this script as root!\n"; exit 1

    case $CURRENT_DISTRIBUTION in
        "arch") bootstrap_arch ;;
        "ubuntu") bootstrap_ubuntu ;;
        *)
            printf "This script does not know how to bootsrap on %s\n" $CURRENT_DISTRIBUTION
            exit 1
            ;;
    esac

    printf "If you had any errors, see the log at $LOGFILE\n"
    echo "Now symlinking the dotfiles"


    #link_dotfiles
}

function show_bootstrap_screen() {
    tput cup 0 0
    tput clear
    printf "${bold}Bootstrapping...${normal}\n\n"
}

function bootstrap_arch() {
    show_bootstrap_screen
    printf "Pacaur"

    if package_is_needed "pacaur"; then
        mkdir -p /tmp/pacaur_install
        cd /tmp/pacaur_install

        tput cup 1 $BOOTSTRAP_STATUS_COL
        printf "Installing dependencies"
        pacman -S binutils make gcc fakeroot expac yajl git --noconfirm --needed > $LOGFILE 2>&1

        tput cup 1 $BOOTSTRAP_STATUS_COL
        printf "Installing cower"

        if [ ! -n "$(pacman -Qs cower)" ]; then
            curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower > $LOGFILE 2>&1
            makepkg PKGBUILD --skippgpcheck --install --needed > $LOGFILE 2>&1
        fi

        tput cup 1 $BOOTSTRAP_STATUS_COL
        printf "Installing pacaur"

        if [ ! -n "$(pacman -Qs pacaur)" ]; then
            curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur > /tmp/bootstrap.log 2>&1
            makepkg PKGBUILD --install --needed > $LOGFILE 2>&1
        fi
    fi

    tput cup 1 $BOOTSTRAP_STATUS_COL
    [[ $? -eq 0 ]] && printf "Done                     \n" || printf "${bold} ERROR ${normal}      \n"

    printf "Common packages"
    pacaur -Syu --needed --noconfirm $ARCH_PACKAGE_LIST > $LOGFILE 2>&1

    tput cup 2 $BOOTSTRAP_STATUS_COL
    [[ $? -eq 0 ]] && printf "Done                     \n" || printf "${bold} ERROR ${normal}      \n"

    printf "NPM modules"
    npm install -g $NODE_PACKAGE_LIST > $LOGFILE 2>&1

    tput cup 3 $BOOTSTRAP_STATUS_COL
    [[ $? -eq 0 ]] && printf "Done                     \n" || printf "${bold} ERROR ${normal}      \n"

    printf "TPM"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > $LOGFILE 2>&1
    chown -R "$USER":"$USER" ~/.tmux/plugins/tpm

    tput cup 4 $BOOTSTRAP_STATUS_COL
    [[ $? -eq 0 ]] && printf "Done                     \n" || printf "${bold} ERROR ${normal}      \n"

}

if [ "$1" '==' "bootstrap" ]; then
    bootstrap
else
    link_dotfiles
fi
