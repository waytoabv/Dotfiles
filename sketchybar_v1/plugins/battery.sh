#!/bin/bash

source "$CONFIG_DIR/colors.sh"
TMP="/tmp/drawing_state.txt"

render_item() {

  PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
  CHARGING=$(pmset -g batt | grep 'AC Power')
  CHARGING_LABEL="Not charging"
  COLOR=$ICON_COLOR
  local DRAWING=$(get_label_state)

  if [ $PERCENTAGE = "" ]; then
    exit 0
  fi

  case ${PERCENTAGE} in
  9[0-9] | 100)
    ICON="􀛨"
    ;;
  [6-8][0-9])
    ICON="􀺸"
    ;;
  [3-5][0-9])
    ICON="􀺶"
    ;;
  [1-2][0-9])
    ICON="􀛩"
    COLOR=$(getcolor yellow)
    DRAWING="on"
    ;;
  *)
    ICON="􀛪"
    COLOR=$(getcolor red)
    DRAWING="on"
    ;;
  esac

  if [[ $CHARGING != "" ]]; then
    ICON="􀢋"
    CHARGING_LABEL="Charging"
  fi

  sketchybar --set $NAME icon=$ICON icon.color=$COLOR label=$PERCENTAGE% label.color=$LABEL_COLOR label.drawing=$DRAWING
}

render_popup() {
  sketchybar --set $NAME.details label="$PERCENTAGE% (${CHARGING_LABEL})"
}

save_label_state() {
  echo "$(sketchybar --query $NAME | jq -r '.label.drawing')" > $TMP
}

get_label_state() {
  cat "$TMP"
}

label_toggle() {
  if [[ $(get_label_state) == "on" ]]; then
    DRAWING="off"
  else
    DRAWING="on"
  fi
  
  sketchybar --set $NAME label.drawing=$DRAWING
  save_label_state
}

update() {
  render_item
  render_popup
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
"mouse.clicked")
  label_toggle
  ;;
"routine" | "forced" | "power_source_change")
  update
  ;;
"mouse.entered")
  popup on
  ;;
"mouse.exited" | "mouse.exited.global")
  popup off
  ;;
esac
