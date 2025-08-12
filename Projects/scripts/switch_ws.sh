#!/bin/env bash

pkill rofi
dialog="rofi -dmenu -p Switch-to: -l 0"
msg="i3-msg"

if [ "wayland" == "${XDG_SESSION_TYPE}" ];
then
    dialog="wofi --dmenu -p Switch-to: "
fi

x=$(echo "" | $dialog) 

if [ "Hyprland" == "${XDG_SESSION_DESKTOP}" ]; 
then
    msg="hyprctl dispatch"
else if [ "sway" == "${XDG_SESSION_DESKTOP}" ];
    then
        msg = "swaymsg"
    fi
fi

if [ "x" != "x${x}" ]
then
  $msg workspace ${x}
fi
