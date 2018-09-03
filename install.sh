#!/bin/sh

# Created by Pascal Riesinger
# Licensed under MIT license. Feel free to copy these files and base your own
# dotfiles on mine.

[ -d "$HOME/.dotfiles" ] || { echo "Cloning dotfiles..."; git clone git@github.com:riesinger/dotfiles .dotfiles; }

pkg_install()
{
	command -v $1 >/dev/null 2>&1 && { echo "$1 is already installed"; return; }
	command -v pacman >/dev/null 2>&1 &&	
}

# Check if zsh is installed
pkg_install git

