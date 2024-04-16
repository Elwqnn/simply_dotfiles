#!/usr/bin/env sh

theme="$HOME/.config/rofi/launchers/type-4/style-10"
wallPath="/home/axo/Pictures/wallpapers/gruvbox"

# launch rofi menu
wallpaper=$(find -L "${wallPath}" -type f -exec basename {} \; | rofi -dmenu -theme ${theme}.rasi)

# apply wallpaper
if [ ! -z "${wallpaper}" ] ; then
  selected="${wallPath}/${wallpaper}"

  swww img $selected \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-fps 75 \
    --transition-duration 1.8 \

  dunstify "Changed Wallpaper to ${wallpaper}" -a "Wallpaper" -i "${selected}" -r 91190 -t 2200
fi
