#!/bin/bash

# There can be only one
SCRIPT_NAME=$(basename "$0")
CURRENT_PID=$$
pgrep -f "$SCRIPT_NAME" | grep -v "$CURRENT_PID" | xargs -r kill

green="0xff8aff80"

INTERVAL=5

while true; do
  unread=$(sqlite3 "$HOME/Library/Messages/chat.db" \
	"SELECT COUNT(guid) FROM message WHERE NOT(is_read) AND NOT(is_from_me) AND text !=''")

  if [[ "$unread" =~ ^[0-9]+$ && "$unread" -gt 0 ]]; then
	sketchybar --set widgets.messages \
	  label.drawing=on \
	  label="$unread" \
	  icon.drawing=on \
	  icon.color=$green \
	  background.drawing=on
  else
	sketchybar --set widgets.messages \
	  label.drawing=off \
	  icon.drawing=off \
	  background.drawing=off
  fi

  sleep $INTERVAL
done
