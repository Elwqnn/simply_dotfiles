#!/bin/bash

entries="Area Window Screen"

selected=$(printf '%s\n' $entries | wofi --style=$HOME/.config/wofi/style.widgets.css --conf=$HOME/.config/wofi/config.screenshot | awk '{print tolower($1)}')

case $selected in
  area)
    hyprshot -m region;;
  window)
    hyprshot -m window;;
  screen)
    hyprshot -m output;;
esac
