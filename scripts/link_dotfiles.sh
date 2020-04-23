#!/usr/bin/env zsh

# Links dotfiles from .dotfiles to their respective destination

[ "$1" = "--dry-run" ] && DRY_RUN=1

[ -z $DOTFILES ] && dotdir=$(readlink -e $(dirname $0) | awk 'BEGIN{FS=OFS="/"}{NF--; print}') || dotdir="$DOTFILES"

echo "🔗 Linking dotfiles from ${dotdir}"

function link {
	filepath="$1"
	targetDirectory="$2" # Target directory (absolute)

	fileBasename=$(basename $filepath)
	# if the filepath contains .symlink, we should replace that with a dot in front of the file's
	# basename
	if [[ "${fileBasename}" == *'.symlink' ]]; then
		fileBasename=".$(echo $fileBasename | sed -e 's/.symlink//g')"
	fi

	if [ -z "$targetDirectory" ]; then
		destination="$HOME/$fileBasename"
	else
		destination="$targetDirectory/$fileBasename"
		[ ! "$(ls -dl "$targetDirectory" | awk '{ print $3 }')" = "$USER" ] && NEEDS_SUDO=1
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
		printf "🔗 %s ➜ %s\n" $filepath $destination
		# cannot harm to delete the old file
		if [ -z "$NEEDS_SUDO" ]; then
			if [ -z "$DRY_RUN" ]; then
				rm -r $destination 2> /dev/null
				ln -s "$filepath" "$destination"
			else
				echo "rm -r $destination 2> /dev/null"
				echo "ln -s \"$filepath\" \"$destination\""
			fi
		else
			if [ -z "$DRY_RUN" ]; then
				sudo rm -r $destination 2> /dev/null
				sudo ln -s "$filepath" "$destination"
			else
				echo "sudo rm -r $destination 2> /dev/null"
				echo "sudo ln -s \"$filepath\" \"$destination\""
			fi
		fi
	fi
}

# Collect all .symlink files, which will be directly linked to $HOME
find $dotdir -type f -name '*.symlink' | while read file; do link "$file"; done

# Collect all folders in config/ which will be directly linked to $HOME/.config/
find $dotdir/config/* -maxdepth 0 -type d | while read folder; do link "$folder" "$HOME/.config"; done

# Collect all files in config/ which will be linked to $HOME/.config/<filename>
find $dotdir/config/* -maxdepth 0 -type f | while read file; do link "$file" "$HOME/.config"; done

# All custom binaries inside /usr/local/bin
find $dotdir/usr/local/bin/* -maxdepth 0 -type f | while read bin; do link "$bin" "/usr/local/bin"; done

# All global configs inside /etc
# TODO: Handle subdirectories
find $dotdir/etc/* -maxdepth 0 -type f | while read bin; do link "$bin" "/etc"; done
