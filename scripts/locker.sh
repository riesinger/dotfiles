#!/bin/bash


lock() {
	font='Google Sans'

	swaylock -i $HOME/.wallpaper -K -e \
		--indicator-radius=20 \
		--ring-color=ffffffff --inside-color=373445ff --line-uses-inside \
		--key-hl-color=ff3333ff --bs-hl-color=ff3333ff --separator-color=00000000 \
		--inside-ver-color=e6b450ff --inside-wrong-color=ff3333ff \
		--ring-ver-color=ffffffff --ring-wrong-color=ffffffff"
		#--indpos=x+50:y+1030 \
		#--timecolor=ffffffff --timestr=%H:%M --timepos=ix+50:iy+10 --force-clock --time-align=1 \
		#--datestr="" \
		#--veriftext="" --wrongtext="" --noinputtext="" --locktext="" --lockfailedtext="" \
		#--screen=2"
}

case "$1" in
	-l)
		lock
		;;
esac

