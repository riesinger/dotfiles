#!/usr/bin/env bash

file="/tmp/updates_available"

checkupdates | sed -e 's/->/→/g' | column -t > $file
numUpdates=$(wc -l $file | awk '{ print $1 }')
if (( numUpdates > 0 )); then
	if [[ $numUpdates == 1 ]]; then
		echo "$numUpdates | iconName=software-update-available-symbolic"
	else
		echo "$numUpdates | iconName=software-update-available-symbolic"
	fi
	echo '---'
	updates="$(cat $file | awk 1 ORS="\\\\n")"
	echo "$updates | font=monospace"
else
	echo '| iconName=checkbox-checked-symbolic'
	echo '---'
fi
