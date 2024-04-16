#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

theme="$HOME/.config/rofi/launchers/type-4/style-10"

## Run
if [[ $1 == "dmenu" ]]; then
    selected=$(ls ~/.scripts/ | rofi -dmenu -p "Run" -theme ${theme}.rasi && hyprctl dispatch focuswindow Rofi) && bash ~/.scripts/$selected
else
    rofi -show $1 -theme ${dir}/${theme}.rasi && hyprctl dispatch focuswindow Rofi
fi
