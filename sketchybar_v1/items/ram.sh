#!/usr/bin/env sh
sketchybar --add item  ram center \
           --set ram script="$PLUGIN_DIR/ram.sh" \
                           update_freq=60 \
                           label.font="$FONT:Bold:9.0" \
                           icon.font="$FONT:Bold:11.0" \
                           y_offset=5                      \
                           label.width=dynamic                       \
                           icon.drawing=on                      \
                           width=0                               \
                           icon=󰍛 \
                           padding_left=4   \
                           icon.padding_right=6 \
           --add item  swap center \
           --set       swap script="$PLUGIN_DIR/swap.sh" \
                           update_freq=60 \
                           label.font="$FONT:Bold:9.0" \
                           icon.font="$FONT:Bold:12.0" \
                           label.width=dynamic                        \
                           icon.drawing=on                      \
                           y_offset=-5                      \
                           icon=󰓡 \
                           padding_left=4