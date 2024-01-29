#!/bin/sh

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

music_item_defaults=(
  align=center
  width=240
  label.max_chars=32
)

music_cover=(
  background.image=media.artwork
  background.image.scale=7
  background.image.corner_radius=5
  background.image.padding_left=8
  background.image.padding_right=8
  y_offset=-$PADDINGS
  align=center
)

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

render_popup() {
  sketchybar --set $NAME.cover "${music_cover[@]}"   \
             --set $NAME.artist "${music_artist[@]}" \
             --set $NAME.title "${music_title[@]}"   \
             --set $NAME.album "${music_album[@]}"
}

update() {
  CURRENT_ARTIST="$(echo "$INFO" | jq -r '.artist')"
  CURRENT_SONG="$(echo "$INFO" | jq -r '.title')"
  CURRENT_ALBUM="$(echo "$INFO" | jq -r '.album')"
  PLAYER_STATE="$(echo "$INFO" | jq -r '.state')"

  if [ "$PLAYER_STATE" = "playing" ]; then
    sketchybar --set $NAME drawing=on                      \
                           icon=􀊆                          \
                           icon.padding_right=5   \
               --set $NAME.artist label="$CURRENT_ARTIST"  \
               --set $NAME.title label="$CURRENT_SONG"     \
               --set $NAME.album label="$CURRENT_ALBUM"
    render_bar_item
    render_popup

  else
    sketchybar --set $NAME icon=􀊄
    popup off
    sketchybar --set $NAME drawing=off
  fi
  
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

playpause() {
  osascript -e 'tell application "Music" to playpause'
}
  

case "$SENDER" in
"routine" | "forced" | "media_change")
  update
  ;;
"mouse.entered")
  popup on
  ;;
"mouse.exited" | "mouse.exited.global")
  popup off
  ;;
"mouse.clicked")
  playpause
  ;;
esac