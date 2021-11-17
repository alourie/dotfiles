#!/bin/env bash

LIST="code ij ij-hidef pycharm goland"
x=$(echo ${LIST} | sed -e "s/ /\n/g" | rofi -dmenu -p "Select IDE: ")

if [ "x" != "x${x}" ]
then
    case "${x}" in
        code)
            ide="code"
        ;;
        ij)
            ide="idea"
            ;;
        ij-hidef)
            ide="GDK_SCALE=2 idea"
            ;;
        pycharm)
            ide="/opt/PyCharm/bin/pycharm.sh"
            ;;
        goland)
            ide="/opt/GoLand/bin/goland.sh"
            ;;
    esac
fi

${ide}
