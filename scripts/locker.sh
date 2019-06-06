#!/bin/bash


set_wallpaper() {
	feh --bg-fill $HOME/.wallpaper
}

lock() {
	font='Google Sans'

	#Constants
	DISPLAY_RE="([0-9]+)x([0-9]+)\\+([0-9]+)\\+([0-9]+)" # Regex to find display dimensions
	CACHE_FOLDER="$HOME/.cache/lock"
	if ! [ -e $CACHE_FOLDER ]; then
			mkdir -p $CACHE_FOLDER
	fi

	BKG_IMG="$HOME/.wallpaper"

	if ! [ -e "$BKG_IMG" ]; then
			echo '$HOME/.wallpaper does not exist'
			exit 2
	fi

	MD5_BKG_IMG=$(md5sum $BKG_IMG | cut -c 1-10)
	MD5_SCREEN_CONFIG=$(xrandr | md5sum - | cut -c 1-32) # Hash of xrandr output
	OUTPUT_IMG="$CACHE_FOLDER""$MD5_SCREEN_CONFIG"."$MD5_BKG_IMG".png # Path of final image
	OUTPUT_IMG_WIDTH=0 # Decide size to cover all screens
	OUTPUT_IMG_HEIGHT=0 # Decide size to cover all screens

	#i3lock command
	LOCK_CMD="i3lock -i $OUTPUT_IMG --radius=20 -t -e \
		--ringcolor=ffffffff --insidecolor=373445ff --line-uses-inside \
		--keyhlcolor=ff3333ff --bshlcolor=ff3333ff --separatorcolor=00000000 \
		--insidevercolor=e6b450ff --insidewrongcolor=ff3333ff \
		--ringvercolor=ffffffff --ringwrongcolor=ffffffff \
		--indpos=x+50:y+1030 \
		--timecolor=ffffffff --timestr=%H:%M --timepos=ix+50:iy+10 --force-clock --time-align=1 \
		--datestr="" \
		--veriftext="" --wrongtext="" --noinputtext="" --locktext="" --lockfailedtext="" \
		--screen=2"

	if [ -e $OUTPUT_IMG ]
	then
			# Lock screen since image already exists
			$LOCK_CMD
			exit 0
	fi

	#Execute xrandr to get information about the monitors:
	while read LINE
	do
		#If we are reading the line that contains the position information:
		if [[ $LINE =~ $DISPLAY_RE ]]; then
			#Extract information and append some parameters to the ones that will be given to ImageMagick:
			SCREEN_WIDTH=${BASH_REMATCH[1]}
			SCREEN_HEIGHT=${BASH_REMATCH[2]}
			SCREEN_X=${BASH_REMATCH[3]}
			SCREEN_Y=${BASH_REMATCH[4]}

			CACHE_IMG="$CACHE_FOLDER""$SCREEN_WIDTH"x"$SCREEN_HEIGHT"."$MD5_BKG_IMG".png
			## if cache for that screensize doesnt exist
			if ! [ -e $CACHE_IMG ]
			then
		# Create image for that screensize
					eval convert '$BKG_IMG' '-resize' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}^' '-gravity' 'Center' \
						'-crop' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}+0+0' '-blur' '0x5' '+repage' '$CACHE_IMG'
			fi

			# Decide size of output image
			if (( $OUTPUT_IMG_WIDTH < $SCREEN_WIDTH+$SCREEN_X )); then OUTPUT_IMG_WIDTH=$(($SCREEN_WIDTH+$SCREEN_X)); fi;
			if (( $OUTPUT_IMG_HEIGHT < $SCREEN_HEIGHT+$SCREEN_Y )); then OUTPUT_IMG_HEIGHT=$(( $SCREEN_HEIGHT+$SCREEN_Y )); fi;

			PARAMS="$PARAMS $CACHE_IMG -geometry +$SCREEN_X+$SCREEN_Y -composite "
		fi
	done <<<"`xrandr`"

	#Execute ImageMagick:
	eval convert -size ${OUTPUT_IMG_WIDTH}x${OUTPUT_IMG_HEIGHT} 'xc:black' $OUTPUT_IMG
	eval convert $OUTPUT_IMG $PARAMS $OUTPUT_IMG

	#Lock the screen:
	$LOCK_CMD


	# i3lock -i "$CACHEDIR/${monitor_name}.jpg" -e \
		# --radius $radius
		# --ringcolor=ffffffff --insidecolor=00000000 \
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
		# --verifytext='...' \
		# --wrongtext='wrong' \
		# --noinputtext=''
}

case "$1" in
	-l)
		lock
		;;
	-w)
		set_wallpaper
		;;
esac

