#!/usr/bin/env bash

entries=" Lock\n Suspend\n Reboot\n Poweroff\n Logout"

selected=$( echo -e $entries | wofi -W 300 -H 300 --dmenu | awk '{print tolower($2)}' )

case $selected in
  lock)
    swaylock;;
  reboot)
    exec systemctl reboot;;
  poweroff)
    exec systemctl poweroff -i;;
  suspend)
    exec systemctl suspend;;
  logout)
    hyprctl dispatch exit;;
esac