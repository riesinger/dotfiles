#!/usr/bin/env zsh

local root_config_files=.zshenv

mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin

for fileOrDirectory in .config/*; do
	echo "🔗 $(pwd)/.config/$fileOrDirectory -> $HOME/$fileOrDirectory"
	ln -sf $(pwd)/$fileOrDirectory $HOME/.config
done

for script in .local/bin/*; do
	echo "💾 $(pwd)/$script -> $HOME/$script"
	cp $(pwd)/$script $HOME/.local/bin
done

for configFile in $root_config_files; do
	echo "🔗 $(pwd)/$configFile -> $HOME/$configFile"
	ln -sf $(pwd)/$configFile $HOME
done
