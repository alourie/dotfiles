#!/usr/bin/env sh

## Add this to your wm startup file.

# Fix keyboard
update-keys

# Terminate already running bar instances
killall -q polybar
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
  pkill polybar;
  sleep 1; 
done

# Launch bar on all screens
sleep 1;
for m in $(polybar --list-monitors | cut -d":" -f1); do
    echo "Launch for $m"
    MONITOR=$m polybar --reload $m -r 2>&1 &
    sleep 1
done
