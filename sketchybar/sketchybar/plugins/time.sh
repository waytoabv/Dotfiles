#!/usr/bin/env sh

sketchybar --set $NAME label="$(date '+%H:%M':%S)"


# with seconds (Datetime needs label.algin=left to not jump around with every sec)
# sketchybar --set $NAME label="$(date '+%H:%M:%S')"



# like
# --set time "${time[@]}"                                        \
#                          label.font="$FONT:Bold:12"            \
#                          label.y_offset=-4                     \
#                          label.width=60                        \
#                          label.align=left                      \
#                          label.padding_left=5                  \
#                          icon.drawing=off                      \
#                          update_freq=1                         \
#                          script="$PLUGIN_DIR/time.sh"          \
#                          click_script="open -a BusyCal.app"    \