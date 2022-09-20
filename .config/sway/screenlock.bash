#!/bin/bash

##
# This script takes a screenshot of the current screen, adds a blur effect &
# locks the screen, using the image as background
#
# Credit: Thomas Leister - https://github.com/ThomasLeister
# See https://thomas-leister.de/en/sway-window-manager#lockscreen
##

IMAGE=/tmp/lockscreen.png

grim -o "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" $IMAGE

convert $IMAGE -scale 25% -blur 0x2 -scale 400% -fill black -colorize 50% $IMAGE
[[ -f $1 ]] && convert $IMAGE "$1" -gravity center -composite -matte $IMAGE

swaylock -i $IMAGE

unset IMAGE

# For more information,
# see https://github.com/swaywm/swaylock
##
