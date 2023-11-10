#!/usr/bin/env bash

# Check release
if [ ! -f /etc/arch-release ] ; then
    exit 0
fi

# Update local package repository databases
# yay -Sy

# Check for updates
aur=$(yay -Qua | wc -l)
ofc=$(pacman -Qu | wc -l)

all=$(checkupdates | wc -l)

# Calculate total available updates
upd=$(( ofc + aur ))
echo "$all"

# Show tooltip
if [ $upd -eq 0 ] ; then
    echo " Packages are up to date"
else
    # echo "Off: $ofc | AUR: $aur"
    echo "Pending updates : $all"
fi

# Trigger upgrade
if [ "$1" == "up" ] ; then
    kitty --title systemupdate sh -c 'yay -Syu' && echo "$all"
fi
