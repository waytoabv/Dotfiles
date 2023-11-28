#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
	ICON=󰌾
	LABEL="VPN"

fi

sketchybar --set $NAME background.color=$COLOR \
	icon=$ICON \
	icon.color=$ICON_COLOR \
	label="$LABEL" \
	label.color=$LABEL_COLOR \
	
	