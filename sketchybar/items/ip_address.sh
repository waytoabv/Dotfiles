sketchybar --add item  ip_address right                              \
           --set       ip_address script="$PLUGIN_DIR/ip_address.sh" \
                                  update_freq=30                     \
                                  padding_right=10                   \
                                  padding_left=5                      \
                                  icon.highlight=off                  \
                                  label.highlight=off                 \
           --subscribe ip_address wifi_change                        \
