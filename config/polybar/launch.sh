#!/bin/sh

if has_executable 'xrandr'; then
	for m in $(monitor_info | awk '{print $1}'); do
		MONITOR=$m polybar --reload main &
	done
else
	echo "You don't have xrandr installed, launching on the first available screen only"
	polybar --reload main &
fi
