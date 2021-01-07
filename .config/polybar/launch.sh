#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar on all screens
sleep 1;
for m in $(polybar --list-monitors | cut -d":" -f1); do
    echo "Launch for $m"
    MONITOR=$m polybar --reload main -r&
    sleep 1
done
