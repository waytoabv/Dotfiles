#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=10
    padding_left=2
    padding_right=2
    label.padding_right=20
    icon.highlight_color=$RED
    label.color=$GREY
    label.highlight_color=$WHITE
    label.font="sketchybar-app-font:Regular:16.0"
    label.y_offset=-1
    background.border_color=$GREY
    background.height=23
    background.color=$BAR_COLOR
    blur_radius=5
    background.corner_radius=9
    blur_radius=10
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

space_creator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=5
  padding_right=5
  label.drawing=on
  display=active
  click_script='yabai -m space --create'
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_windows_change
