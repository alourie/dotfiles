#!/bin/env bash

LIST="code ij pycharm goland"
x=$(echo ${LIST} | sed -e "s/ /\n/g" | rofi -dmenu -p "Select IDE: ")

if [ "x" != "x${x}" ]
then
    case "${x}" in
        code)
            ide="code"
        ;;
        ij)
            ide="/opt/IntelliJ/bin/idea.sh"
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
