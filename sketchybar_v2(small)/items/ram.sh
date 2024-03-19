#!/usr/bin/env sh

ram=( script="$PLUGIN_DIR/ram.sh"
      update_freq=60
      label.font="SF Mono:Bold:8.5"
      icon.font="$FONT:Bold:8.0"
      label.y_offset=5
      icon.y_offset=4
      label.width=35
      label.align=left
      icon.drawing=on
      width=0
      icon=󰍛
      padding_left=4
)

swap=( script="$PLUGIN_DIR/swap.sh"
       update_freq=60
       label.font="SF Mono:Bold:8.5"
       icon.font="$FONT:Bold:8.0"
       label.width=35
       icon.drawing=on
       label.y_offset=-3
       icon.y_offset=-5
       icon=󰓡
       padding_left=4
)


sketchybar --add item  ram right   \
           --set ram "${ram[@]}"   \
                                   \
           --add item  swap right  \
           --set swap "${swap[@]}" \
                           