#!/usr/bin/env sh
sketchybar --add item  ram right \
           --set ram "${ram[@]}" \
                           script="$PLUGIN_DIR/ram.sh"  \
                           update_freq=60               \
                           label.font="$FONT:Bold:9.0"  \
                           icon.font="$FONT:Bold:11.0"  \
                           y_offset=5                   \
                           label.width=37               \
                           label.align=right            \
                           icon.drawing=on              \
                           width=0                      \
                           icon=󰍛                       \
                           padding_left=4               \
                           icon.padding_right=9         \
           --add item  swap right                       \
           --set swap "${swap[@]}"                      \
                           script="$PLUGIN_DIR/swap.sh" \
                           update_freq=60               \
                           label.font="$FONT:Bold:9.0"  \
                           icon.font="$FONT:Bold:12.0"  \
                           label.width=dynamic          \
                           icon.drawing=on              \
                           y_offset=-5                  \
                           icon=󰓡                       \
                           padding_left=4