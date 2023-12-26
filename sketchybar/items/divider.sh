# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh" 

sketchybar --add item divider right \
           --set divider label.drawing=on \
                         icon=􀫰 \
                         icon.font="$FONT:Heavy:18.0" \
                         background.padding_left=5 \
                         background.padding_right=-14
