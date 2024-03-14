#!/bin/env/bash

battery=(
  "${menu_defaults[@]}"
  icon.font.size=14
  label.font.size=11
  icon.padding_right=2
  update_freq=60                                             
  popup.align=right                                            
  click_script="sketchybar --set battery popup.drawing=toggle" 
  script="$PLUGIN_DIR/battery.sh"                              
  updates=when_shown
  padding_right=7                                                         
)

sketchybar                                 \
  --add item battery right                 \
  --set battery "${battery[@]}"            \
  --subscribe battery power_source_change  \
                      mouse.entered        \
                      mouse.exited         \
                      mouse.exited.global  \
                      mouse.clicked \
  --add item battery.details popup.battery \
  --set battery.details "${menu_item_defaults[@]}" icon.drawing=off label.padding_left=0