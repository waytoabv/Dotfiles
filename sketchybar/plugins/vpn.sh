#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
  sketchybar -m --set $NAME label="󰌾 VPN" label.drawing=on label.padding_left=4 label.padding_right=4
else
  sketchybar -m --set $NAME icon.drawing=off label.drawing=off
fi
	