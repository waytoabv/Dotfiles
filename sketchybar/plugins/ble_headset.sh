#!/usr/bin/env bash

DEVICES=$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq -rc '.SPBluetoothDataType[0].devices_list[]? | select( .[] | .device_minorType == "Headphones" and .device_connected =="Yes") | keys[]')

if [ "$DEVICES" = "" ]; then
  sketchybar --set $NAME drawing=off background.padding_right=0 background.padding_left=0 label=""
  sketchybar --set headphones_logo drawing=off
else
  DEVICES="$(echo $DEVICES | rev | cut -d" " -f3- | rev)"
  sketchybar --set $NAME drawing=on label="$DEVICES" background.height=28 background.color=0xff3B4252
  sketchybar --set headphones_logo drawing=on icon=  background.color=0xff5E81AC background.height=28 background.padding_left=5
fi
