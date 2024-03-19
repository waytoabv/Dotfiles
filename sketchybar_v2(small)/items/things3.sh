# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

things3=(
  "${notification_defaults[@]}"
  drawing=on
  icon.drawing=off
  label.padding_left=8
  background.color=$(getcolor cyan)
  script="$PLUGIN_DIR/things3.sh"
  click_script="open -a /Applications/Things3.app"
)

sketchybar --add item things3 right           \
           --set      things3 "${things3[@]}"