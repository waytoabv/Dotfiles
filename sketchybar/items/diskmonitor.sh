#!/bin/bash

diskmonitor=(
  icon.font="CaskaydiaCove Nerd Font Mono:Regular:24"
  label.drawing=off
  y_offset=1
  update_freq=360
  updates=when_shown
  script="$PLUGIN_DIR/diskmonitor.sh"
  background.padding_left=7
)

misc=(
  icon.drawing=off
  width=0
  padding_right=4
  update_freq=360
  updates=when_shown
)

diskmonitor_label=(
  "${misc[@]}"
  label.font="$FONT:Semibold:8"
  label=SSD
  y_offset=5
)

diskmonitor_value=(
  "${misc[@]}"
  label.font="$FONT:Bold:10"
  y_offset=-3
)

sketchybar   --add item diskmonitor center                      \
  --set diskmonitor "${diskmonitor[@]}"             \
  --subscribe diskmonitor mouse.clicked               \
                                                      \
  --add item diskmonitor.label center                \
  --set diskmonitor.label "${diskmonitor_label[@]}" \
                                                    \
  --add item diskmonitor.value center                \
  --set diskmonitor.value "${diskmonitor_value[@]}" \
                                                    \
  
