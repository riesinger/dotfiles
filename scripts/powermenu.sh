#!/bin/sh

roficommand="rofi -dmenu -columns 4 -lines 1 -theme themes/powermenu"

# lock, suspend, poweroff, restart
option=$(echo -e "\n\n\n" | $roficommand)

case $option in
	 )
		locker.sh -l
		;;
	 )
		systemctl suspend
		;;
	 )
		systemctl poweroff
		;;
	 )
		systemctl reboot
esac
