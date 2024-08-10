#!/bin/bash

window_id=$YABAI_WINDOW_ID
window_data=$(yabai -m query --windows --window "$window_id")
can_resize=$(echo "$window_data" | jq '.["can-resize"]')
floating=$(echo "$window_data" | jq '.["is-floating"]')

if [[ "$can_resize" == "false" ]] && [[ "$floating" == "false" ]]; then
    yabai -m window "$window_id" --toggle float
    osascript -e 'display notification "Float successful"'
    exit 0
fi

display_id=$(echo "$window_data" | jq '.display')
display_area=$(yabai -m query --displays --display "$display_id" | jq '.frame.w * .frame.h')
min_area=$(bc <<< "$display_area * 0.10")
window_area=$(echo "$window_data" | jq '.frame.w * .frame.h')

if (( $(bc <<< "$window_area < $min_area") == 1 )) && [[ "$floating" == "false" ]]; then
    yabai -m window "$window_id" --toggle float
    osascript -e 'display notification "Float successful"'
fi