#!/bin/bash

hyprctl dispatch movetoworkspace $1

bash ~/.config/ags/shared/scripts/changemode.sh normal
bash ~/.config/ags/shared/scripts/sidebar.sh close
bash ~/.config/ags/shared/scripts/wallpapers.sh close
