#!/bin/bash
#

set -o errexit

if at-laptop; then
    xrandr --output eDP1 --auto \
           --output HDMI2 --auto --left-of eDP1
fi

exit 0
