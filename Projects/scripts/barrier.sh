#!/usr/bin/env zsh

function stop() { killall barriers& }
function start() {
    /usr/bin/barriers -f --no-tray --debug INFO --name firefly --enable-crypto -c $HOME/.config/barrier/config --address :24800
}

function running {
   return $(pgrep -x barriers > /dev/null)
}

function status {
    # set non-running colour
    colour="#bf616a"
    # if running, change color
    if running; then
        colour="#a3be8c"
    fi
    if [[ $2 = "xmonad" ]]; then
        echo "<fc=${colour}></fc>"
    else
        echo "%{F${colour}}%{F-}"
    fi
}

if [ $1 = "check" ]; then
    status $2
    exit 0
fi

if [ $1 = "toggle" ]; then
    if running; then
        stop
    else
        start
    fi
    exit 0
fi

# Just run it if no params
stop
start
