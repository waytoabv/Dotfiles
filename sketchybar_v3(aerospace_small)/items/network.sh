#!/usr/bin/env sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

network_up=(    label.font="SF Mono:Bold:8.5"
                icon.font="$FONT:Bold:8.0"
                label.width=42
                icon.padding_right=2
                icon.drawing=on
                icon=􀆇
                icon.highlight_color=$BLUE
                label.highlight_color=$BLUE
                label.y_offset=5
                icon.y_offset=4
                width=0
                update_freq=2
                script="$PLUGIN_DIR/network.sh"
)

network_down=(  label.font="SF Mono:Bold:8.5"
                icon.font="$FONT:Bold:8.0"
                label.width=42
                icon.padding_right=2
                icon=􀆈
                icon.drawing=on
                icon.highlight_color=$YELLOW
                label.highlight_color=$YELLOW
                label.y_offset=-3
                icon.y_offset=-4
                icon.padding_left=7
                update_freq=2
)


sketchybar    --add item network_up right               \
              --set network_up "${network_up[@]}"       \
                                                        \
              --add item network_down right             \
              --set network_down "${network_down[@]}"   \