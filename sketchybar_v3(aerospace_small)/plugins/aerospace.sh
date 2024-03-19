#!/usr/bin/env bash

source "$CONFIG_DIR/globalstyles.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.highlight=on \
                           label.font="$FONT:Black:13.0" \
                           background.drawing=on
else
    sketchybar --set $NAME label.highlight=off \
                           label.font="$FONT:Heavy:13.0" \
                           background.drawing=off
fi
