#!/usr/bin/env sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

sketchybar --add item  ram right \
           --set ram script="$PLUGIN_DIR/ram.sh" \
                           update_freq=60 \
                           label.font="$FONT:Bold:10.0" \
                           icon.font="$FONT:Bold:11.0" \
                           y_offset=5                      \
                           label.align=center                \
                           label.width=38                        \
                           icon.drawing=on                      \
                           width=0                               \
                           background.border_width=0 \
                           icon=󰍛 \
           --add item  swap right \
           --set       swap script="$PLUGIN_DIR/swap.sh" \
                           update_freq=60 \
                           label.font="$FONT:Bold:10.0" \
                           icon.font="$FONT:Bold:12.0" \
                           label.width=38                        \
                           icon.drawing=on                      \
                           y_offset=-5                      \
                           background.border_width=0 \
                           icon=󰓡 \
                           background.padding_left=5 \