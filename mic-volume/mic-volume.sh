#!/bin/sh

DEFAULT_SOURCE=$(pactl get-default-source)

display_volume() {
	if [ -z "$volume" ]; then
	  echo "No Mic Found"
	else
          volume=${volume% /*}
          volume=${volume#*/ }
          volume=${volume#*/ }
          volume=${volume#*/ }
	  volume="${volume//[[:blank:]]/}"
          mute=${mute#*: }
	  if [[ "$mute" == *"yes"* ]]; then
	    echo "[$volume]"
	  elif [[ "$mute" == *"no"* ]]; then
	    echo "$volume"
	  else
	    echo "$volume !"
	  fi
	fi
}

case $1 in
	"show-vol")
		if [ -z "$2" ]; then
  			volume=$(pactl get-source-volume $DEFAULT_SOURCE)
  			mute=$(pactl get-source-mute $DEFAULT_SOURCE)
			display_volume
		else
  			volume=$(pactl get-source-volume $2)
  			mute=$(pacmd get-source-mute $2)
			display_volume
		fi
		;;
	"inc-vol")
		if [ -z "$2" ]; then
			pactl set-source-volume $DEFAULT_SOURCE +5%
		else
			pactl set-source-volume $2 +5%
		fi
		;;
	"dec-vol")
		if [ -z "$2" ]; then
			pactl set-source-volume $DEFAULT_SOURCE -5%
		else
			pactl set-source-volume $2 -5%
		fi
		;;
	"mute-vol")
		if [ -z "$2" ]; then
			pactl set-source-mute $DEFAULT_SOURCE toggle
		else
			pactl set-source-mute $2 toggle
		fi
		;;
	*)
		echo "Invalid script option"
		;;
esac
