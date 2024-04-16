#!/bin/sh

function active_window() {
  class=`hyprctl activewindow -j | jq -r '.class'`
  default='~'

  if [[ ! -z $class ]]; then
    echo $class
  else
    echo $default
  fi
}

active_window "activewindow"
socat -u "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do active_window "$line"; done
