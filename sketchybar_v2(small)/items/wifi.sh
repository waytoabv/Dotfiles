#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

source "$CONFIG_DIR/icons.sh"

wifi=(
  padding_right=0
  label.width=0
  icon.padding_right=0
  icon="$WIFI_DISCONNECTED"
  script="$PLUGIN_DIR/wifi.sh"
  icon.font.size=12
  y_offset=1
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change mouse.clicked



