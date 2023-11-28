#!/usr/bin/env sh

sketchybar --set $NAME icon="$(LC_TIME="de_DE.UTF-8" date '+%a %d. %b')" label="$(date '+%H:%M:%S')"
