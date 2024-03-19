#!/usr/bin/env sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

zeit=(  label.font="SF Mono:Bold:10"
        label.y_offset=-4
        label.width=60
        label.align=center
        background.padding_left=5
        background.padding_right=5
        icon.drawing=off
        update_freq=1
        script="$PLUGIN_DIR/time.sh"
        click_script="$PLUGIN_DIR/zen.sh"
)

date=(  "${menu_defaults[@]}"
        label.font="SF Pro:Medium:8"
        label.y_offset=5
        label.width=60
        label.align=center
        icon.drawing=off
        background.padding_left=5
        background.padding_right=5
        width=0
        update_freq=30
        script="$PLUGIN_DIR/date.sh"
        click_script="$PLUGIN_DIR/zen.sh"
)





sketchybar --add item  date right                               \
           --set date "${date[@]}"                              \
                                                                \
           --add item  zeit right                               \
           --set zeit "${zeit[@]}"                              \