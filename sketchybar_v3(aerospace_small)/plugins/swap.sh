#!/bin/sh

source "$CONFIG_DIR/colors.sh"

# Swap-Nutzung abrufen
USAGE=$(sysctl vm.swapusage)
SWAP=$(echo $USAGE | awk '/vm.swapusage: / { sub(/.$/, "", $7); print int($7) }')

# Swap-Nutzung formatieren
if [ "$SWAP" -lt "1" ]; then
  # Weniger als 1000 MB
  SWAP_FORMAT=$(printf "0.00 Mb" )
elif [ "$SWAP" -lt "1000" ]; then
  # Weniger als 1000 MB
  SWAP_FORMAT=$(printf "%03d Mb" $SWAP)
elif [ "$SWAP" -lt "10000" ]; then
  # 1 GB bis 9,99 GB
  SWAP_FORMAT=$(printf "%.2f Gb" $(echo "scale=2; $SWAP / 1000" | bc))
else
  # Ab 10 GB
  SWAP_FORMAT=$(printf "%.1f Gb" $(echo "scale=1; $SWAP / 1000" | bc))
fi

case ${SWAP} in
  10000 | [1-9][0-9][0-9][0-9][0-9])
    COLOR=$RED
    LABEL=$SWAP_FORMAT
    ;;
  2000 | [2-9][0-9][0-9][0-9])
    COLOR=$RED
    LABEL=$SWAP_FORMAT
    ;;
  1000 | [1][0-9][0-9][0-9])
    COLOR=$ORANGE
    LABEL=$SWAP_FORMAT
    ;;
  100 | [1-9][0-9][0-9])
    COLOR=$YELLOW
    LABEL=$SWAP_FORMAT
    ;;
  10 | [1-9][0-9])
    COLOR=$YELLOW
    LABEL=$SWAP_FORMAT
    ;;
  1 | [2-9])
    COLOR=$YELLOW
    LABEL=$SWAP_FORMAT
    ;;
  *)
    COLOR=$ICON_COLOR
    LABEL=$SWAP_FORMAT
    ;;
esac


# Output an sketchybar übergeben
sketchybar -m --set $NAME label="$SWAP_FORMAT" icon.color=$COLOR label.color=$COLOR 
