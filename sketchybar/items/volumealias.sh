#!/bin/sh

sketchybar --add alias "Kontrollzentrum,Sound" right                      \
           --rename "Kontrollzentrum,Sound" volume_alias                  \
           --set volume_alias icon.drawing=on                             \
                              alias.scale=0.9                            \
                              alias.color=$GREY                           \
                              alias.update_freq=5