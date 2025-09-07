#!/bin/bash

device="intel_backlight"
direction="$1"

current=$(brightnessctl -d "$device" get)
max=$(brightnessctl -d "$device" max)
percent=$(( current * 100 / max ))

if [ "$direction" = "down" ]; then
    if [ "$percent" -le 10 ]; then
        step="1%"
    else
        step="5%"
    fi
    brightnessctl -d "$device" set "${step}-"
else
    if [ "$percent" -lt 10 ]; then
        step="1%"
    else
        step="5%"
    fi
    brightnessctl -d "$device" set "${step}+"
fi

pkill -USR1 -x i3status

