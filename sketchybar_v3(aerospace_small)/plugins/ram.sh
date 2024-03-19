#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Swap-Nutzung abrufen
USAGE=$(memory_pressure | grep "System-wide memory free percentage:" )
PERCENTAGE=$(echo $USAGE | awk '{ printf("%02.0f%%", 100 - $5) }')



case ${PERCENTAGE} in
  [8-9][0-9] | 100)
    COLOR=$RED
    LABEL="KILL ME"
    ;;
  [6-7][0-9])
    COLOR=$RED
    LABEL=$PERCENTAGE
    ;;
  [3-5][0-9])
    COLOR=$ORANGE
    LABEL=$PERCENTAGE
    ;;
  2[0-9])
    COLOR=$YELLOW
    LABEL=$PERCENTAGE
    ;;
  *)
    COLOR=$ICON_COLOR
    LABEL=$PERCENTAGE
    ;;
esac

sketchybar -m --set $NAME label="$LABEL" icon.color=$COLOR label.color=$COLOR

# PERCENTAGE=$(echo $USAGE | awk '{ printf("%02.0f%%", 100 - $5) }')


# sketchybar --set $NAME label="$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')%"