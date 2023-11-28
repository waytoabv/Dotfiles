#!/usr/bin/env sh

#!/bin/bash

front_app=(
  label.font="$FONT:Black:12.0"
  icon.background.drawing=on
  icon.=0.5
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched

front_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  blur_radius=5
)

sketchybar --add bracket front front_app \
           --set front "${front_bracket[@]}" \