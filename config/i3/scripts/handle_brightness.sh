#!/bin/bash

device="intel_backlight"
direction="$1"

current=$(brightnessctl -d "$device" get)
max=$(brightnessctl -d "$device" max)
percent=$(( current * 100 / max ))

if [ "$percent" -le 10 ]; then
  step="1%"
else
  step="5%"
fi

if [ "$direction" = "up" ]; then
  brightnessctl -d "$device" set "${step}+"
else
  brightnessctl -d "$device" set "${step}-"
fi

