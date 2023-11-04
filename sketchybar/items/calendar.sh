#!/usr/bin/env sh

sketchybar --add item     calendar right                    \
           --set calendar icon=cal                          \
                          icon.font="$FONT:Black:12.0"      \
                          icon.padding_right=5              \
                          label.width=60                    \
                          label.align=right                 \
                          background.padding_left=15        \
                          update_freq=1                    \
                          script="$PLUGIN_DIR/calendar.sh"  \
                          click_script="$PLUGIN_DIR/zen.sh"
