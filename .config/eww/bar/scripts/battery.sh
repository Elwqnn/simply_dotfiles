#!/bin/sh

get_battery() {
    battery=`cat /sys/class/power_supply/BAT0/capacity | jq -r`
    echo $battery%
}

get_battery "getbattery"
socat -u "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do get_battery "$line"; done
