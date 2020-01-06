#!/usr/bin/env zsh

# Links dotfiles from .dotfiles to their respective destination

[ -z $DOTFILES ] && dotdir=$(readlink -e $(dirname $0) | awk 'BEGIN{FS=OFS="/"}{NF--; print}') || dotdir="$DOTFILES"

echo "🔗 Linking dotfiles from ${dotdir}"

function link {
	filepath="$1"
	targetDirectory="$2" # Target directory relative to $HOME

	fileBasename=$(basename $filepath)
	# if the filepath contains .symlink, we should replace that with a dot in front of the file's
	# basename
	if [[ "${fileBasename}" == *'.symlink' ]]; then
		fileBasename=".$(echo $fileBasename | sed -e 's/.symlink//g')"
	fi

	if [ -z "$targetDirectory" ]; then
		destination="$HOME/$fileBasename"
	else
		destination="$HOME/$targetDirectory/$fileBasename"
	fi

	overwrite="y"
	if [ -h "${destination}" ]; then
		echo "✅ ${destination} is already linked"
		return
	elif [ -e "${destination}" ]; then
		echo -n "❓ ${destination} already exists, do you want to overwrite it? [Y,n] "
		read -k overwrite
	fi
	if [ "$overwrite" = "n" ]; then
		printf " Skipped\n"
	else
		printf "\n🔗 %s ➜ %s\n" $filepath $destination
		# cannot harm to delete the old file
		rm -r $destination 2> /dev/null
		ln -s "$filepath" "$destination"
	fi
}

# Collect all .symlink files, which will be directly linked to $HOME
find $dotdir -type f -name '*.symlink' | while read file; do link "$file"; done

# Collect all folders in config/ which will be directly linked to $HOME/.config/
find $dotdir/config/* -maxdepth 0 -type d | while read folder; do link "$folder" ".config"; done

# Collect all files in config/ which will be linked to $HOME/.config/<filename>
find $dotdir/config/* -maxdepth 0 -type f | while read file; do link "$file" ".config"; done

