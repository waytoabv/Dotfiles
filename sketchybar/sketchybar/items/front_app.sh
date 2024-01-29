
#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

front_app=(
  label.font="$FONT:Black:12.0"
  icon.background.drawing=on
  background.padding_right=7
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched

