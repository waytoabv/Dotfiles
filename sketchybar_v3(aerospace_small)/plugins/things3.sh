INBOX=$(osascript -e 'tell application "Things3" to return count of to dos of list "Inbox"')
TODAY=$(osascript -e 'tell application "Things3" to return count of to dos of list "Today"')

args=(label.drawing=on label="$INBOX""|""$TODAY")

if [[ $INBOX -eq 0 ]] && [[ $TODAY -eq 0 ]]; then args=(drawing=off); fi

sketchybar  --set $NAME "${args[@]}"

#!/bin/bash

# Path to the Things 3 database file
DATABASE_PATH="/Users/lukas/Library/Group Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-07GH6/Things Database.thingsdatabase/main.sqlite"

QUERY="SELECT COUNT(*) FROM TMTask WHERE trashed = 0 AND start = 0 AND area = (SELECT uuid FROM TMArea WHERE type = 0 AND title = 'Inbox');SELECT COUNT(*) FROM TMTask WHERE trashed = 0 AND start = 0 AND area IN (SELECT uuid FROM TMArea WHERE type = 0 AND title = 'Inbox');"


# Execute the query using sqlite3 and print the result
sqlite3 "$DATABASE_PATH" "$QUERY"
