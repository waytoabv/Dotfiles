#!/usr/bin/env sh

sketchybar --add item        cpu.top right                  \
           --set cpu.top     label.font="$FONT:Bold:7"      \
                             label=CPU                      \
                             icon.drawing=off               \
                             width=0                        \
                             y_offset=6                     \
                             label.padding_right=5          \
                                                            \
           --add item        cpu.percent right              \
           --set cpu.percent label.font="$FONT:Heavy:12"    \
                             label=CPU                      \
                             y_offset=-4                    \
                             background.padding_right=-2    \
                             width=40                       \
                             icon.drawing=off               \
                             update_freq=1                  \
                             mach_helper="$HELPER"          \
                                                            \
           --add graph       cpu.sys right 70               \
           --set cpu.sys     width=0                        \
                             graph.color=$RED               \
                             graph.fill_color=$TRANSPARENT  \
                             y_offset=5                    \
                             label.drawing=off              \
                             icon.drawing=off               \
                             background.padding_right=-7    \
                             background.padding_left=0      \
                             background.height=30           \
                             background.drawing=on          \
                             background.color=$TRANSPARENT  \
                                                            \
           --add graph       cpu.user right 70              \
           --set cpu.user    graph.color=$BLUE              \
                             label.drawing=off              \
                             icon.drawing=off               \
                             y_offset=5                    \
                             background.padding_right=-7    \
                             background.padding_left=0      \
                             background.height=30           \
                             background.drawing=on          \
                             background.color=$TRANSPARENT
