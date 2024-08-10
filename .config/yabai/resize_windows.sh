#!/bin/bash

WINDOW_RESIZE_AMOUNT=100
WINDOW=$(yabai -m query --windows --window)
SPLIT_TYPE=$(echo $WINDOW | jq -r '."split-type"')

resize() {
    if [[ $SPLIT_TYPE == "vertical" ]]; then
        echo "right:$1$WINDOW_RESIZE_AMOUNT:0"
    else
        echo "bottom:0:$1$WINDOW_RESIZE_AMOUNT"
    fi
}

if [[ $1 = "decrease" ]]; then
    yabai -m window --resize $(resize "-")
elif [[ $1 = "increase" ]]; then
    yabai -m window --resize $(resize "")
else
    echo "Invalid flag entered."
fi
