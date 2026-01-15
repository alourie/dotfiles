#!/usr/bin/env bash

desktop=""

env | rg XDG_CURRENT_DESKTOP | rg -i sway > /dev/null
if [ $? = 0 ]; then
    # Running on sway
    desktop=sway
else
    env | rg XDG_CURRENT_DESKTOP | rg -i hypr > /dev/null 
    if [ $? = 0 ]; then
        # Running on sway
        desktop=hyprland
    fi
fi

echo "Detected $desktop" | tee /tmp/waybar.log

sed -e "s/ENV/$desktop/g" ~/.config/waybar/config.DP-3.template > ~/.config/waybar/config.DP-3
sed -e "s/ENV/$desktop/g" ~/.config/waybar/config.e-DP1.template > ~/.config/waybar/config.e-DP1

waybar -c $HOME/.config/waybar/config -s $HOME/.config/waybar/style.css
