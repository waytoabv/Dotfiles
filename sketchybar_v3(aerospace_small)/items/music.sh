#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

music=(
  "${bracket_defaults[@]}"
  script="$PLUGIN_DIR/music.sh"
  padding_left=0
  icon.padding_right=5
  icon=􀊆
  drawing=off
  label=…
  background.image=media.artwork
  background.image.padding_left=3
  background.image.scale=0.68
  background.image.corner_radius=5
  icon.padding_left=32
  label.max_chars=75
  label.scroll_duration=300
  label.width=dynamic
  label.padding_right=7
  background.padding_right=4
  updates=on       
)

sketchybar                               \
  --add item music right                \
  --set      music "${music[@]}"         \
                   "${menu_defaults[@]}" \
  --subscribe music media_change         \
                    mouse.clicked