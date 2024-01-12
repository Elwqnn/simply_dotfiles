#!/bin/bash

entries="Area Window Screen"

selected=$(printf '%s\n' $entries | wofi -W 200 -H 200 --dmenu | awk '{print tolower($2)}' )

case $selected in
  area)
    hyprshot -m region;;
  window)
    hyprshot -m window;;
  screen)
    hyprshot -m output;;
esac
