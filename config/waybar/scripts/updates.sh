#!/usr/bin/zsh

# Displays number of upgradeable packages.
# For this to work, run `checkupdates > /tmp/available_updates` in the background as a cronjob.
# When clicked, it will run an upgrade via pacman.
#
# Add the following text as a file in /usr/share/libalpm/hooks/statusbar.hook:
#
# [Trigger]
# Operation = Upgrade
# Type = Package
# Target = *
#
# [Action]
# Description = Updating statusbar...
# When = PostTransaction
# Exec = /usr/bin/pkill -RTMIN+8 waybar

updatefile=/tmp/available_updates

if [ -f "$updatefile" ]; then
	updates="$(wc -l "$updatefile" | awk '{ print $1 }')"
	if [ "$updates" = "0" ]; then
		echo -e "${updates}\n\nnone-available"
	else
		echo -e "${updates}\nClick to install updates\nupdates-available"
	fi
else
	echo -e "?\nThe updates file does not exist\nunknown"
fi
