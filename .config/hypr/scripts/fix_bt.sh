#!/bin/sh

sudo rmmod btusb
sleep 10
sudo modprobe btusb
bluetoothctl power on
