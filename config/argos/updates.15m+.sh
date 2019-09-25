#!/usr/bin/env bash

updates="$(checkupdates | awk '{ print $1 }')"
numUpdates=$(echo -n "$updates" | wc -l)
if (( numUpdates > 0 )); then
	if [[ $numUpdates == 1 ]]; then
		echo "$numUpdates update available | iconName=software-update-available-symbolic"
	else
		echo "$numUpdates updates available | iconName=software-update-available-symbolic"
	fi
	echo '---'
	for pkg in $updates; do
		echo $pkg
	done
else
	echo 'No updates | iconName=checkbox-checked-symbolic'
	echo '---'
fi

