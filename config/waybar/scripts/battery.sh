#!/usr/bin/env zsh
# Script that averages all available battery's charges and formats them for waybar
#
# Dependencies:
# 	- jq
# 	- battery (script from dotfiles)

get_classes() {
	echo "${1}" | grep 'Charging' && { echo 'charging'; return }
	[[ ${2} -lt 25 ]] && { echo 'warning'; return }
	[[ ${2} -lt 15 ]] && { echo 'critical'; return }
	echo 'discharging'
}

# Output

total="$(battery | grep 'Total')"
total_capacity=$(echo "${total}" | awk '{ print $2 }' | cut -d '%' -f 1)
classes="$( get_classes "${total}" ${total_capacity} )"
tooltip="$( battery | grep -v 'Total' | awk 1 ORS='\\n')"

jq --unbuffered --compact-output <<EOD
{
	"text": "${total_capacity}",
	"tooltip": "${tooltip}",
	"class": "${classes}",
	"percentage": ${total_capacity}
}
EOD
