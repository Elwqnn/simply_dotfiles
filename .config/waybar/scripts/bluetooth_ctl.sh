#!/bin/bash

bluetooth_status=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$bluetooth_status" ]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi
