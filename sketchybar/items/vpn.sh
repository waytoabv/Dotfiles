# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

sketchybar --add item  ip_address right                              \
           --set       ip_address script="$PLUGIN_DIR/vpn.sh" \
                                  update_freq=30                     \
                                  icon.padding_left=15        \
                                  background.padding_right=2        \
                                  icon.highlight=off                 \
                                  label.highlight=off                \
           --subscribe ip_address wifi_change                        \



