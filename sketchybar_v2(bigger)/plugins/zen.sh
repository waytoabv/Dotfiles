#!/bin/bash

zen_on() {
  sketchybar --set logo drawing=off \
             --set '/cpu.*/' drawing=off \
             --set ram drawing=off \
             --set swap drawing=off \
             --set network_up drawing=off \
             --set network_down drawing=off \
             --set diskmonitor drawing=off \
             --set diskmonitor.label drawing=off \
             --set diskmonitor.value drawing=off \
             --set space_icons drawing=off \
             --set front_app drawing=off \
             --set space_creator drawing=off
}

zen_off() {
  sketchybar --set logo drawing=on \
             --set '/cpu.*/' drawing=on \
             --set ram drawing=on \
             --set swap drawing=on \
             --set network_up drawing=on \
             --set network_down drawing=on \
             --set diskmonitor drawing=on \
             --set diskmonitor.label drawing=on \
             --set diskmonitor.value drawing=on \
             --set space_icons drawing=on \
             --set front_app drawing=on \
             --set space_creator drawing=on 
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query logo | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi