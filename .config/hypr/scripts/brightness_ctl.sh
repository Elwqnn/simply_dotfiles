#!/usr/bin/env bash

function get_brightness {
	brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'
}

function send_notification {
  icon="preferences-system-brightness-lock"
  brightness=$(get_brightness)
  bar=$(seq -s "─" 0 $(((brightness - 1) / 4)) | sed 's/[0-9]//g')
  space=$(seq --separator=" " 0 "$(((100 - brightness) / 4))" | sed 's/[0-9]//g')
  dunstify -i "$icon" -r 5555 -u normal "|$bar$space| $brightness%"
}

case $1 in
  up)
    brightnessctl set 5%+
    send_notification
    ;;
  down)
    brightnessctl set 5%-
    send_notification
    ;;
  max)
    brightnessctl set 100%
    send_notification
    ;;
  blank)
    brightnessctl set 5%
    send_notification
    ;;
esac
