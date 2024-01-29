#!/usr/bin/env sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"


sketchybar -m --add item topmem right \
              --set topmem update_freq=5 \
                    script="$PLUGIN_DIR/topmem.sh" \
                    label.font="$FONT:Bold:12.0" \
                    lazy=off \
