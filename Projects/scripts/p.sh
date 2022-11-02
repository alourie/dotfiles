#!/bin/env bash

dialog="rofi -dmenu -p Name: -l 0"

if [ "wayland" == "${XDG_SESSION_TYPE}" ]
then
    dialog="wofi --dmenu -p Name: "
fi

echo $dialog
selection=$(echo "" | $dialog)
if [ "x" != "x${selection}" ]
then
  pass -c ${selection}
fi
