#!/usr/bin/env sh

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.ABC') LABEL='􀅒' ;;
'com.apple.keylayout.PinyinKeyboard') LABEL='拼' ;;
esac

sketchybar --set $NAME label="$LABEL"