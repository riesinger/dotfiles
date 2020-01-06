#!/bin/sh

# Argos script to show a warning symbol in the panel, when a file in $DOTFILES (~/.dotfiles) has
# changed

if [ -z "$DOTFILES" ]; then
	echo "$DOTFILES does not exist"
	exit 1
fi

cd "$DOTFILES"
if [ -z "$(git status --short 2>/dev/null)" ]; then # No files changed
	echo "---"
else
	echo -e " | iconName=dialog-warning-symbolic"
fi
