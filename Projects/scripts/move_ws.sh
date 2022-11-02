#!/bin/env bash

pkill rofi
dialog="rofi -dmenu -p 'Move to: '"
msg="i3-msg"

if [ "wayland" == "${XDG_SESSION_TYPE}" ]
then
    dialog="wofi --dmenu -L 1 -H 1 -b -p 'Move to: '"
    msg="swaymsg"
fi

x=$(echo "" | $dialog) 

if [ "x" != "x${x}" ]
then
  $msg move container to workspace ${x}; $msg workspace ${x}
fi
