#!/bin/zsh

[ -z $DOTFILES ] && dotdir=$(readlink -e $(dirname $0) | awk 'BEGIN{FS=OFS="/"}{NF--; print}') || dotdir="$DOTFILES"

printf "=== Linking dotfiles from %s ===\n" $dotdir

function link_file {
	f=$1
	fBase=$(basename $f)
	destName=".$(echo $fBase | sed -e 's/.symlink//g')"
	dest="$HOME/$destName"
	overwrite="y"
	if [ -f "$dest" ]; then
		printf "> %s already exists, do you want to overwrite it? [Y,n] " $dest;\
		read -k overwrite;\
		echo ""
	fi
	if [ "$overwrite" = "n" ]; then
		printf "Skipping %s\n" $fBase
	else
		printf "Linking %s -> %s\n" $f $dest
		# cannot harm to delete the old file
		rm $dest 2> /dev/null
		ln -s "$f" "$dest"
	fi
}

function link_dir {
	d=$1
	printf "Linking %s\n" $d
}

# Collect all .symlink files, which will be directly linked to $HOME
find $dotdir -type f -iname '*.symlink' | while read file; do link_file "$file"; done

# Collect all folders in config/ which will be directly linked to $HOME/.config/
find $dotdir/config/* -maxdepth 0 -type d | while read folder; do link_dir "$folder"; done
