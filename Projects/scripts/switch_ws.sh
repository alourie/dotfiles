#!/bin/env bash

pkill rofi
dialog="rofi -dmenu -p Switch-to: -l 0"
msg="i3-msg"

if [ "wayland" == "${XDG_SESSION_TYPE}" ]
then
    dialog="wofi --dmenu -p Switch-to: "
    msg="swaymsg"
fi

x=$(echo "" | $dialog) 

if [ "x" != "x${x}" ]
then
  $msg workspace ${x}
fi

