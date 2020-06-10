#!/bin/env sh

# https://www.reddit.com/r/bspwm/comments/gye2hr/im_testing_a_new_way_to_move_around_windows/
# move focus fron one monitor to another
# provide monitor name as input:
MONITOR_NAME=$1
FOCUSED_MONITOR="$(bspc query -M -m --names)"

if [ "$FOCUSED_MONITOR" = "$MONITOR_NAME" ]; then
    bspc node -f next.local
else
    bspc monitor -f $MONITOR_NAME;
    # I removed the following line and I think it's better without it
    # bspc node -f biggest.local
fi
