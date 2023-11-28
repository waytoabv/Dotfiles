sketchybar -m --add event song_update com.apple.Music.playerInfo \
              --add item music_info center \
              --set music_info script="$PLUGIN_DIR/music.sh" \
              --subscribe music_info song_update   


musik_bracket=(
  background.drawing=on
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  blur_radius=5
)

sketchybar --add bracket music music_info \
           --set music "${musik_bracket[@]}" \
                      