#!/bin/bash

source "$CONFIG_DIR/colors.sh"

update() {
PERCENTAGE=$(df -H /System/Volumes/Data | awk 'END {print $5}' | sed 's/%//')

COLOR=$LABEL_COLOR

case ${PERCENTAGE} in
  9[8-9] | 100)
    ICON="󰪥"
    COLOR=$RED
    ;;
  8[8-9] | 9[0-7])
    ICON="󰪤"
    COLOR=$ORANGE
    ;;
  7[6-9] | 8[0-7])
    ICON="󰪣"
    COLOR=$YELLOW
    ;;
  6[4-9] | 7[0-5])
    ICON="󰪢"
    ;;
  5[2-9] | 6[0-3])
    ICON="󰪡"
    ;;
  4[0-9] | 5[0-1])
    ICON="󰪠"
    ;;
  2[8-9] | 3[0-9])
    ICON="󰪟"
    ;;
  1[6-9] | 2[0-7])
    ICON="󰪞"
    ;;
  [0-9] | 1[0-5])
    ICON="󰝦"
    ;;
  *)
    # Handle other cases if needed
    ICON="󰅚"
    COLOR=$HIGHLIGHT
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.color=$COLOR
sketchybar --set $NAME.value label="$PERCENTAGE%"
}

label_toggle() {

  DRAWING_STATE=$(sketchybar --query $NAME.value | jq -r '.label.drawing')
  
  if [[ $DRAWING_STATE == "on" ]]; then
    DRAWING="off"
    PADDING="0"
  else
    DRAWING="on"
    PADDING="2"
  fi

  sketchybar --set $NAME.value label.drawing=$DRAWING \
             --set $NAME.label label.drawing=$DRAWING \
             --set $NAME icon.padding_right=$PADDING
}


case "$SENDER" in
"routine" | "forced")
  update
  ;;
"mouse.clicked")
  label_toggle
  ;;
esac
