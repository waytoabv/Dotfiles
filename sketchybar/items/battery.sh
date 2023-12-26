#!/bin/bash
# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

battery=(
  background.padding_right=7
  icon.padding_right=4
  icon.padding_left=-2
  icon.font="$FONT:Regular:19.0"
  update_freq=60
  updates=on
  script="$PLUGIN_DIR/battery.sh"
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
                 click_script="open -a BatteryBoi.app" \                         
           --subscribe battery power_source_change system_woke 
           



