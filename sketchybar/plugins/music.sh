#!/bin/sh


# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

#music_event=defaults read com.apple.Music.playerInfo
#sketchybar --add event media_change $music_event


music_artist=(
  "${music_item_defaults[@]}"
)

music_title=(
  "${music_item_defaults[@]}"
  label.font.style="Bold"
)

music_album=(
  "${music_item_defaults[@]}"
)

render_bar_item() {
  sketchybar --set $NAME label="$CURRENT_ARTIST - $CURRENT_SONG"
}

update() {
  APP_STATE="$(echo "$INFO" | jq -r '.app')"
  PLAYER_STATE="$(echo "$INFO" | jq -r '.state')"
  if [ "$APP_STATE" = "Musik" ]; then
      if [ "$PLAYER_STATE" = "playing" ]; then
        CURRENT_ARTIST=$(osascript -e 'tell application "Music" to get artist of current track')
        CURRENT_SONG=$(osascript -e 'tell application "Music" to get name of current track')
        CURRENT_ALBUM=$(osascript -e 'tell application "Music" to get album of current track')

        sketchybar --set $NAME  drawing=on                      \
                                icon=􀊆                          
        render_bar_item
      elif [ "$PLAYER_STATE" = "paused" ]; then
        sketchybar --set $NAME icon=􀊄 \
                               drawing=on
      fi
  else
  sketchybar --set $NAME drawing=off
  fi
}

playpause() {
  osascript -e 'tell application "Music" to playpause'
}
  

case "$SENDER" in
"routine" | "forced" | "media_change")
  update
  ;;
"mouse.clicked")
  playpause
  ;;
esac
