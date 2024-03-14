# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

vpn=(   update_freq=2
        click_script="open -a ProtonVPN.app"
        y_offset=1
        icon.font.size=8
)


sketchybar --add item  vpn right                                        \
           --set       vpn "${vpn[@]}"                                  \
                           script="$PLUGIN_DIR/vpn.sh"                  \
           --subscribe vpn wifi_change                                  \


