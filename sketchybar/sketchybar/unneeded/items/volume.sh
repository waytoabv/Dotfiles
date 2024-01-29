#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$BLUE
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=􀀁
  slider.knob.drawing=on
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  icon=$ICON
  icon.width=0
  icon.align=left
  icon.color=$GREY
  icon.font="$FONT:Regular:14.0"
  background.padding_left=7
  label.width=30
  label.align=left
  label.font="$FONT:Regular:14.0"
)



sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
