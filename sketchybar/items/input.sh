#!/usr/bin/env sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
    --add item input right\
    --set input script="$PLUGIN_DIR/input.sh" \
          icon=􀇳 \
          icon.font="$FONT:Black:12.0"      \
    --subscribe input input_change 