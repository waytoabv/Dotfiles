#!/bin/bash

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

PADDINGS=2 # All paddings use this value (icon, label, background)
FONT="SF Pro" # Needs to have Regular, Bold, Semibold, Heavy and Black variants

# Bar Appearance
bar=(
  height=26                                         
  color=$TRANSPARENT                   
  shadow=off                                        
  position=top                                      
  padding_right=6                                  
  padding_left=6                                 
  corner_radius=2                                   
  y_offset=0                                        
  blur_radius=10                                    
  notch_width=30
  topmost=off
)

# Item Defaults
item_defaults=(
  background.color=$TRANSPARENT
  background.padding_left=0
  background.padding_right=0
  background.corner_radius=0
  icon.font="$FONT:Bold:13"
  icon.color=$ICON_COLOR
  icon.highlight_color=$HIGHLIGHT
  icon.padding_left=$PADDINGS
  icon.padding_right=0
  label.font="$FONT:Semibold:12.0"
  label.color=$LABEL_COLOR
  label.highlight_color=$HIGHLIGHT
  label.padding_left=$PADDINGS
  label.padding_right=$PADDINGS
  updates=when_shown
  scroll_texts=on
)

icon_defaults=(
  alias.color=$ICON_COLOR
  label.drawing=off
  padding_left=0
  padding_right=-$PADDINGS
)

bracket_defaults=(
  background.height=22
  background.color=$TRY
  background.border_color=$LIGHT_BLACK
  background.border_width=2
  blur_radius=1
  background.corner_radius=6
  background.padding_left=7
  background.padding_right=7
)

bracket_defaults2=(
  background.height=24
  background.color=$TRY
  background.border_color=$LIGHT_BLACK
  background.border_width=1
  blur_radius=5
  background.corner_radius=6
  background.padding_left=7
  background.padding_right=7
)

menu_defaults=(
  popup.blur_radius=15
  popup.background.color=$LIGHT_GREY
  popup.background.corner_radius=9
  popup.background.shadow.drawing=on
  popup.background.border_width=1
  popup.background.border_color=$BG1
)

menu_item_defaults=(
  label.font="$FONT:Regular:14"
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  icon.padding_left=0
  icon.padding_right=0
  background.color=$TRANSPARENT
)

separator=(
  background.height=1
  width=200
  background.color=$WHITE_25
  background.y_offset=-16
)