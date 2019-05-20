#!/bin/sh

set -x

# Get primary output dimensions
monitor_dims=$(xrandr | grep "primary" | awk '{ print $4 }' | sed -r 's|^([0-9]+)x([0-9]+)\+.*|\1 \2|g')
monitor_width=$(echo $monitor_dims | awk '{print $1}')
monitor_height=$(echo $monitor_dims | awk '{print $2}')


generate_img() {
	# Check if files exist
	if [ ! -f "$HOME/.wallpaper" ]; then
	echo "No wallpaper found at $HOME/.wallpaper"
	exit 1
	fi

	if [ ! -f "$HOME/.face" ]; then
	echo "No picture found at $HOME/.face"
	exit 1
	fi

	# Read picture dimensions
	wall_dims=$(convert "$HOME/.wallpaper" -ping -format "%w %h" info:)
	face_dims=$(convert "$HOME/.face" -ping -format "%w %h" info:)

	wall_width=$(echo $wall_dims | awk '{ print $1 }')
	wall_height=$(echo $wall_dims | awk '{ print $2 }')
	face_width=$(echo $face_dims | awk '{ print $1 }')
	face_height=$(echo $face_dims | awk '{ print $2 }')



	if [ "$face_width" != "$face_height" ]; then
		echo "The face image needs to be square"
		exit 2
	fi

	# Make the face rounded
	half_face_width=$((face_width / 2))
	convert "$HOME/.face" \
	\( +clone -threshold -1 -negate -fill white -draw "circle $half_face_width,$half_face_width $half_face_width,0" \) \
	-alpha off -compose copy_opacity -composite /tmp/face_circle.png

	# Add face to wallpaper
	convert -size "${wall_width}x${wall_height}" \
	-page +0+0 "$HOME/.wallpaper" \
	-page "+$((wall_width / 2 - half_face_width))+$((wall_height / 2 - half_face_width))" /tmp/face_circle.png \
	-layers flatten "$HOME/.cache/lock_wallpaper.jpg"

	# Scale wallpaper to monitor size
	convert "$HOME/.cache/lock_wallpaper.jpg" -resize "${monitor_width}x${monitor_height}"^ \
		-gravity center -extent "${monitor_width}x${monitor_height}" -quality 100 "$HOME/.cache/lock_wallpaper.jpg"
}

set_wallpaper() {
	feh --bg-fill $HOME/.wallpaper
}

lock() {
	radius=95
	font='Google Sans'
	timecolor='ffffffff'


	i3lock -i "$HOME/.cache/lock_wallpaper.jpg" # -e --force-clock \
		# --ringcolor=ffffffff --insidecolor=00000000 --radius $radius \
		# --insidevercolor=ffffff22 \
		# --insidewrongcolor="$(xgetres 'color1')22" \
		# --ringvercolor="$(xgetres 'color4')ff" \
		# --ringwrongcolor="$(xgetres 'color1')ff" \
		# --keyhlcolor="$(xgetres 'color2')ff" \
		# --bshlcolor="$(xgetres 'color1')ff" \
		# --separatorcolor=00000000 \
		# --linecolor=00000000 \
		# --timepos="$((monitor_width / 2)):$((monitor_height / 2 - radius * 2))" \
		# --time-font=$font --date-font=$font --layout-font=$font \
		# --timecolor=$timecolor --datecolor=$timecolor \
		# --datestr='%a %d %b' \
		# --veriftext='...' \
		# --wrongtext='wrong' \
		# --noinputtext=''
}

case "$1" in
	-u)
		generate_img
		;;
	-l)
		lock
		;;
	-w)
		set_wallpaper
		;;
esac

