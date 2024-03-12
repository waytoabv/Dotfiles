#!/usr/bin/env sh


sketchybar --add item        cpu.top center                  \
           --set cpu.top     label.font="$FONT:Bold:8"      \
                             label=CPU                      \
                             label.width=80                 \
                             label.max_chars=20             \
                             label.padding_left=20          \
                             label.align=right             \
                             icon.drawing=off               \
                             width=0                        \
                             y_offset=6                     \
                             background.padding_left=35    \
                                                            \
           --add graph       cpu.sys center 60               \
           --set cpu.sys     width=0                        \
                             graph.color=$RED               \
                             graph.fill_color=$TRANSPARENT  \
                             y_offset=3                    \
                             label.drawing=off              \
                             icon.drawing=off               \
                             background.padding_right=-7    \
                             background.padding_left=30      \
                                                            \
           --add graph       cpu.user center 60              \
           --set cpu.user    graph.color=$BLUE              \
                             label.drawing=off              \
                             icon.drawing=off               \
                             y_offset=3                    \
                             background.padding_right=-12    \
                             background.padding_left=30      \
                                                            \
           --add item        cpu.percent center              \
           --set cpu.percent label.font="$FONT:Heavy:12"    \
                             label=CPU                      \
                             y_offset=-4                    \
                             width=40                       \
                             label.padding_right=-10        \
                             label.align=left               \
                             icon.drawing=off               \
                             update_freq=1                  \
                             mach_helper="$HELPER"          \
                             
