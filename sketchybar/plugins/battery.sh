#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

COLOR=$GV_WHITE
case ${PERCENTAGE} in
  9[0-9]|100) ICON=$BATTERY_100; COLOR=$CHARGER_CONNECTED
  ;;
  [6-8][0-9]) ICON=$BATTERY_75;
  ;;
  [3-5][0-9]) ICON=$BATTERY_50; COLOR=$BATTERY_MEDIUM
  ;;
  [1-2][0-9]) ICON=$BATTERY_25; COLOR=$BATTERY_LOW
  ;;
  *) ICON=$BATTERY_0; COLOR=$BATTERY_SUPERLOW
esac

if [[ $CHARGING != "" ]]; then
  ICON=$BATTERY_CHARGING
  COLOR=$CHARGER_CONNECTED
fi

sketchybar --set $NAME  icon="$ICON" icon.color=$WHITE label="$PERCENTAGE%" label.color=$WHITE
