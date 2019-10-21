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
	fi
	if [ "$overwrite" = "n" ]; then
		printf " Skipped\n" $fBase
	else
		printf "\nLinking %s -> %s\n" $f $dest
		# cannot harm to delete the old file
		rm $dest 2> /dev/null
		ln -s "$f" "$dest"
	fi
}

function link_config_dir {
	d=$1
	dBase=$(basename $d)
	destName=".config/$dBase"
	dest="$HOME/$destName"
	overwrite="y"
	if [ -d "$dest" ]; then
		printf "> %s already exists, do you want to overwrite it? [Y,n] " $dest;\
		read -k overwrite;\
	fi
	if [ "$overwrite" = "n" ]; then
		printf " Skipped\n" $dBase
	else
		printf "\nLinking %s -> %s\n" $d $dest
		# cannot harm to delete the old file
		rm -r $dest 2> /dev/null
		ln -s "$d" "$dest"
	fi
}

function link_scripts_dir {
	d="$dotdir/scripts"
	dest="$HOME/.scripts"
	overwrite="y"
	if [ -d "$dest" ]; then
		printf "> %s already exists, do you want to overwrite it? [Y,n] " $dest;\
		read -k overwrite;\
	fi
	if [ "$overwrite" = "n" ]; then
		printf " Skipped scripts directory \n"
	else
		printf "\nLinking %s -> %s\n" $d $dest
		# cannot harm to delete the old file
		rm -r $dest 2> /dev/null
		ln -s "$d" "$dest"
	fi
}

# Collect all .symlink files, which will be directly linked to $HOME
find $dotdir -type f -iname '*.symlink' | while read file; do link_file "$file"; done

# Collect all folders in config/ which will be directly linked to $HOME/.config/
find $dotdir/config/* -maxdepth 0 | while read folder; do link_config_dir "$folder"; done

link_scripts_dir
