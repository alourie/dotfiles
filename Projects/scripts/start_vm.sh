#!/bin/env bash

CONNECT="--connect qemu:///system"
VIRTM="virt-manager ${CONNECT}"
VIRSH="virsh ${CONNECT}"

VM=$(echo $(${VIRSH} list --all --name) | sed -e "s/ /\n/g" | rofi -dmenu -p "Select VM: ")

if [ "x" != "x${VM}" ]
then
    ${VIRTM} --show-domain-console "${VM}"
fi