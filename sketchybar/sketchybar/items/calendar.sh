#!/usr/bin/env sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

sketchybar --add item  date right                               \
           --set date "${date[@]}"                              \
                          label.font="$FONT:Standard:8"         \
                          label.y_offset=6                      \
                          label.width=60                        \
                          label.align=center                    \
                          icon.drawing=off                      \
                          background.padding_left=5             \
                          background.padding_right=5            \
                          width=0                               \
                          update_freq=30                        \
                          script="$PLUGIN_DIR/date.sh"          \
           --add item  time right                               \
           --set time "${time[@]}"                              \
                          label.font="$FONT:Bold:12"            \
                          label.y_offset=-4                     \
                          label.width=60                        \
                          label.align=center                      \
                          background.padding_left=5             \
                          background.padding_right=5            \
                          icon.drawing=off                      \
                          update_freq=1                         \
                          script="$PLUGIN_DIR/time.sh"          \
                          tst click_script="$PLUGIN_DIR/calendarshort.applescript"    \
                          --subscribe mouse.clicked     \
                          