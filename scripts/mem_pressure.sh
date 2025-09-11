#!/bin/bash

SCRIPT_NAME=$(basename "$0")
CURRENT_PID=$$
pgrep -f "$SCRIPT_NAME" | grep -v "$CURRENT_PID" | xargs -r kill

COLOR_DIRTY_WHITE=0xc8cad3f5
COLOR_YELLOW=0xffFFFF80
COLOR_ORANGE=0xffFFCA80
COLOR_RED=0xffFF9580

INTERVAL=2

while true; do
  PCT=$(memory_pressure | grep "System-wide memory free percentage" \
        | sed -E 's/.*: *([0-9]+)%/\1/')
  USED=$((100 - PCT))

  COLOR=$COLOR_DIRTY_WHITE
  if   [ "$USED" -ge 75 ]; then COLOR=$COLOR_RED
  elif [ "$USED" -ge 60 ]; then COLOR=$COLOR_ORANGE
  elif [ "$USED" -ge 50 ]; then COLOR=$COLOR_YELLOW
  fi

  sketchybar --set widgets.ram1 \
    label="${USED} %" \
    label.color=$COLOR \
    icon.color=$COLOR

  sleep $INTERVAL
done
