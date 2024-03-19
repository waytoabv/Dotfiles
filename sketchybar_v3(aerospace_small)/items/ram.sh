#!/usr/bin/env sh

ram=( script="$PLUGIN_DIR/ram.sh"
      update_freq=60
      label.font="SF Mono:Bold:8"
      icon.font="$FONT:Bold:8.0"
      label.y_offset=4
      icon.y_offset=4
      label.width=44
      label.align=left
      icon.drawing=on
      width=0
      icon=󰍛
      padding_left=4
)

swap=( script="$PLUGIN_DIR/swap.sh"
       update_freq=60
       label.font="SF Mono:Bold:8"
       icon.font="$FONT:Bold:8.0"
       label.width=dynamic
       icon.drawing=on
       label.y_offset=-4
       icon.y_offset=-5
       icon=󰓡
       padding_left=4
       label.padding_right=7
       icon.padding_left=5
)


sketchybar --add item  ram right   \
           --set ram "${ram[@]}"   \
                                   \
           --add item  swap right  \
           --set swap "${swap[@]}" \
                           