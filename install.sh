#!/usr/bin/env zsh

local dotfiles_path="$(dirname $(realpath $0))"
echo "Your dotfiles live in $dotfiles_path"
local root_config_files=.zshenv

mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin

for fileOrDirectory in "$dotfiles_path/.config/"*; do
	echo "🔗 $fileOrDirectory -> $HOME/.config/$(basename $fileOrDirectory)"
	ln -sf $fileOrDirectory $HOME/.config
done

for script in "$dotfiles_path/.local/bin/"*; do
	echo "💾 $script -> $HOME/$(basename $script)"
	cp $script $HOME/.local/bin
done

for configFile in $root_config_files; do
	echo "🔗 $dotfiles_path/$configFile -> $HOME/$configFile"
	ln -sf $dotfiles_path/$configFile $HOME
done
