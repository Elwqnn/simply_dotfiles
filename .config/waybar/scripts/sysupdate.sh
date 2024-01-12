#!/usr/bin/env bash

# Check for updates
all=$(checkupdates | wc -l)

# Show pending updates
# if [ $all -eq 0 ] ; then
#     echo "Up to date"
# else
#     echo "$all"
# fi


# Trigger upgrade
if [ "$1" == "up" ] ; then
  kitty --title systemupdate sh -c 'yay -Syu'
fi

echo "$all"