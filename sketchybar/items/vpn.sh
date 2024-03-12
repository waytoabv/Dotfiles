# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

sketchybar --add item  ip_address right                              \
           --set       ip_address script="$PLUGIN_DIR/vpn.sh"           \
                                  update_freq=2                        \
                                  click_script="open -a ProtonVPN.app"  \
                                  label.padding_right=0                 \
                                  label.padding_left=0                 \
           --subscribe ip_address wifi_change                           \



