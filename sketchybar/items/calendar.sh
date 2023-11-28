#!/usr/bin/env sh

sketchybar --add item     calendar right                    \
           --set calendar icon=cal                          \
                          icon.font="$FONT:Black:12.0"      \
                          background.padding_right=7        \
                          label.width=65                    \
                          label.align=right                 \
                          background.padding_left=7         \
                          update_freq=1                     \
                          script="$PLUGIN_DIR/calendar.sh"  \
                          click_script="$PLUGIN_DIR/zen.sh"
time_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  blur_radius=5
)

sketchybar --add bracket time calendar  \
           --set time "${time_bracket[@]}" \
           --add item spacer right                \
           --set spacer background.drawing=off    \
                 width=5                          \    
                      