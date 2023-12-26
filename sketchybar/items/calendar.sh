#!/usr/bin/env sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

sketchybar -m --add item  date right                    \
           --set date "${date[@]}"                         \
                          icon.font="$FONT:Black:11"      \
                          icon.y_offset=5                   \
                          icon.padding_right=$PADDINGS      \
                          icon.padding_left=$PADDINGS      \
                          width=0                            \
                          update_freq=30                     \
                          script="$PLUGIN_DIR/date.sh"      \
           --add item  time right                         \
           --set time "${time[@]}"                         \
                          label.font="$FONT:Semibold:11.5"      \
                          label.y_offset=-5                 \
                          label.width=70                    \
                          label.align=center                 \
                          update_freq=1                     \
                          script="$PLUGIN_DIR/time.sh"    \
                          click_script="open -a BusyCal.app" \
                          