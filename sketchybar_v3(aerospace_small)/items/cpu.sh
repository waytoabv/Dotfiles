#!/bin/bash

cpu_top=(
  label.font="$FONT:Semibold:7"      
  label=CPU                      
  label.width=80          
  label.padding_left=20          
  label.align=right             
  icon.drawing=off               
  width=0                        
  y_offset=5                      
  background.padding_left=0
  label.padding_right=7  
)

cpu_percent=(
  label.font="SF Mono:Bold:9"
  label=CPU
  y_offset=-3
  width=24
  label.padding_right=7
  icon.drawing=off
  update_freq=1
  mach_helper="$HELPER"
)

cpu_sys=(
  width=0
  graph.color=$RED
  graph.fill_color=$RED
  label.drawing=off
  icon.drawing=on
  icon.padding_left=5
  background.drawing=on
  background.color=$TRANSPARENT
  y_offset=5
)

cpu_user=(
  graph.color=$BLUE
  label.drawing=off
  icon.drawing=on
  icon.padding_left=5
  background.drawing=on
  background.color=$TRANSPARENT
  y_offset=5
)

sketchybar --add item cpu.top right              \
           --set cpu.top "${cpu_top[@]}"         \
                                                 \
           --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
                                                 \
           --add graph cpu.sys right 50          \
           --set cpu.sys "${cpu_sys[@]}"         \
                                                 \
           --add graph cpu.user right 50         \
           --set cpu.user "${cpu_user[@]}"



           