#!/bin/sh

zen_on() {
  sketchybar --set apple.logo drawing=off \
             --set wifi drawing=off \
             --set volume_icon drawing=off \
             --set network_down drawing=off \
             --set network_up drawing=off \
             --set '/cpu.*/' drawing=off \
             --set calendar icon.drawing=off \
             --set system.yabai drawing=off \
             --set separator drawing=off \
             --set front_app drawing=off \
             --set brew drawing=off \
             --set divider drawing=off \
             --set battery drawing=off \
             --bar padding_left=18 
}

zen_off() {
  sketchybar --set apple.logo drawing=on \
             --set wifi drawing=on \
             --set volume_icon drawing=on \
             --set network_down drawing=on \
             --set network_up drawing=on \
             --set '/cpu.*/' drawing=on \
             --set calendar icon.drawing=on \
             --set separator drawing=on \
             --set front_app drawing=on \
             --set system.yabai drawing=on \
             --set brew drawing=on \
             --set divider drawing=on \
             --set battery drawing=off \
             --bar padding_left=7
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query apple.logo | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi

