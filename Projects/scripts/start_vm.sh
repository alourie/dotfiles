#!/bin/env bash

killall rofi
CONNECT="--connect qemu:///system"
VIRTM="virt-manager ${CONNECT}"
VIRSH="virsh ${CONNECT}"

VM=$(echo $(${VIRSH} list --all --name) | sed -e "s/ /\n/g" | rofi -dmenu -p "Select VM: ")

if [ "x" != "x${VM}" ]
then
    GDK_SCALE=2 ${VIRTM} --show-domain-console "${VM}"
fi
