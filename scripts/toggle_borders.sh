#!/bin/bash

# Path for temporary files
TMP_DIR="$HOME/.tmp"
STATE_FILE="$TMP_DIR/yabai_toggle_state"

# Ensure the .tmp folder exists
if [[ ! -d "$TMP_DIR" ]]; then
    mkdir -p "$TMP_DIR"
fi

# Initialize state file with default value if it doesn't exist
if [[ ! -f "$STATE_FILE" ]]; then
    echo "off" > "$STATE_FILE"
fi

# Read the current state from the state file
STATE=$(cat "$STATE_FILE")

# Toggle logic based on the current state
if [[ "$STATE" == "off" ]]; then
    # Enable borders
    borders style=round width=6.0 hidpi=off active_color="gradient(top_left=0xddc29df1,bottom_right=0xfff5a97f)" inactive_color=0xc02c2e34 background_color=0x302c2e34
    echo "on" > "$STATE_FILE"
else
    # Disable borders
    borders width=0.0
    echo "off" > "$STATE_FILE"
fi
