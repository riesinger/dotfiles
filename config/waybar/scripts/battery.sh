#!/usr/bin/env zsh
# Script that averages all available battery's charges and formats them for waybar
#
# Dependencies:
# 	- jq

# FIXME: This script does not consider a batteries maximum charge -> small batteries make up the
# same percentage as large ones

detailed_stats() {
	local text=""
	for bat in /sys/class/power_supply/BAT*; do
		cap=$(cat "${bat}/capacity") || exit
		batstatus=$(cat "${bat}/status")

		total_cap=$(( total_cap + cap ))
		text="${text}\\n $(basename ${bat}): ${cap}% - ${batstatus}"
	done
	echo -n "${text}" | tr '\n' ', ' | cut -d ',' -f 2-
}

num_bats=$(ls /sys/class/power_supply | grep 'BAT' | wc -l)
# if we don't have batteries, we don't display anything
[[ $num_bats -lt 1 ]] && exit 0

total_cap=0
charging=false
for bat in /sys/class/power_supply/BAT*; do

	cap=$(cat "${bat}/capacity") || exit
	batstatus=$(cat "${bat}/status")

	total_cap=$(( total_cap + cap ))

	# If any one of the batteries is charging, we want to indicate the charging status
	[[ $batstatus == "Charging" ]] && charging=true
done

avg_cap=$(( total_cap / num_bats ))

get_classes() {
	[[ ${charging} == true ]] && { echo "charging"; return }
	[[ ${avg_cap} -lt 25 ]] && { echo "discharging warning"; return }
	[[ ${avg_cap} -lt 15 ]] && { echo "discharging critical"; return }
	echo 'discharging'
}

# Output

tooltip="$( detailed_stats )"
classes="$( get_classes )"

jq --unbuffered --compact-output <<EOD
{
	"text": "${avg_cap}",
	"tooltip": "${tooltip}",
	"class": "${classes}",
	"percentage": ${avg_cap}
}
EOD
