#!/usr/bin/env bash

source "$CONFIG_DIR/globalstyles.sh"
source "$CONFIG_DIR/colors.sh"

sketchybar --add event aerospace_workspace_change
for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        label.highlight_color=$BLUE \
        label="$sid" \
        label.padding_right=7 \
        background.color=$TRY \
        background.corner_radius=5 \
        background.height=20 \
        background.border_color=$BLUE \
        background.border_width=2 \
        background.drawing=off \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
