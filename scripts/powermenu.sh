#!/bin/sh
# A rofi-based power menu

roficommand="rofi -dmenu -columns 4 -lines 1 -theme themes/powermenu"

iLOCK=
iSLEEP=
iPOWEROFF=
iREBOOT=

# lock, suspend, poweroff, restart
option=$(echo -e "$iLOCK\n$iSLEEP\n$iPOWEROFF\n$iREBOOT" | $roficommand)

case $option in
	$iLOCK )
		locker.sh -l
		;;
	$iSLEEP )
		systemctl suspend
		;;
	$iPOWEROFF )
		systemctl poweroff
		;;
	$iREBOOT )
		systemctl reboot
esac
