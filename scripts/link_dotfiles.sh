#!/bin/sh

[ -d "$HOME/.dotfiles" ] && export DOTFILES="$HOME/.dotfiles" || exit 1

ln -s "$DOTFILES/zshrc.symlink" "$HOME/.zshrc"
ln -s "$DOTFILES/tmux.conf.symlink" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config/nvim"
ln -s "$DOTFILES/config/nvim/init.vim" "$HOME/.config/nvim/init.vim"

