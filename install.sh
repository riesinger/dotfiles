#!/bin/sh

# Created by Pascal "Arial7" Riesinger
# Licensed under MIT license. Feel free to copy these files and base your own
# dotfiles on mine.

# This script will install all of the dotfiles, as well as provide a simple
# 'bootstrap' function wich will install my most commonly used programs and
# tools. Note that this is intended for Archlinux, so bootstraping does not
# work on other distros.


# This function will look for the dotfiles and link them, if they do not exist
# yet. Otherwise, the linking will be skipped.

ARCH_PACKAGE_LIST="neovim htop zsh lm_sensors noto-fonts thefuck termite nodejs npm"
UBUNTU_PACKAGE_LIST="htop zsh lm_sensors nodejs npm"
NODE_PACKAGE_LIST="gulp-cli typescript npm-check-updates tslint typings"

LINUX_DISTRO=$(cat /etc/*-release | grep "ID" | cut -c 4- )

function package_is_needed() {
    hash $1 > /dev/null 2>&1
    if [ $? == "0" ]; then
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
    for file in $linkables ; do
        target="$HOME/.$( basename $file ".symlink" )"
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
    echo "Starting bootstrap..."
    echo "Detected distro is $LINUX_DISTRO, starting installation process"

    if [ $LINUX_DISTRO == "arch" ]; then
        echo "Checking for yaourt"

        if package_is_needed "yaourt"; then
            echo "Downloading package-query and yaourt"

            curl -Os "https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz"
            curl -Os "https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz"

            tar xzf yaourt.tar.gz
            tar xzf package-query.tar.gz

            echo "Building package-query"
            cd package-query
            makepkg -si --noconfirm > /dev/null 2>&1

            if [ $? != "0" ]; then
                echo "There was an error while building package-query, do you have the base-devel group installed?"
                exit 1
            fi

            echo "Building yaourt"
            cd ../yaourt
            makepkg -si --noconfirm > /dev/null 2>&1

            if [ $? != "0" ]; then
                echo "There was an error while building yaourt, exiting..."
                exit 1
            fi

            cd ..

            echo "Cleaning up"
            rm -rf package-query yaourt
            rm package-query.tar.gz yaourt.tar.gz

            echo "Removing .zshrc, so dotfiles will install correctly"
            rm ~/.zshrc

        fi
    fi

    echo "Installing common packages"
    if [ $LINXU_DISTRO == "arch" ]; then
        sudo yaourt -Syu --needed --noconfirm $ARCH_PACKAGE_LIST > /dev/null 2>&1
    elif [ $LINUX_DISTRO == "ubuntu" ]; then
        sudo apt install $UBUNTU_PACKAGE_LIST > /dev/null 2>&1
    fi

    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "Installing common npm modules"
    sudo npm install -g $NODE_PACKAGE_LIST > /dev/null 2>&1

    echo "Finished bootstrap"
    echo "Now symlinking the dotfiles"

    link_dotfiles
}

if [ "$1" == "bootstrap" ]; then
    bootstrap
else
    link_dotfiles
fi
