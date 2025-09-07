#!/bin/bash

sink="@DEFAULT_SINK@"
direction="$1"

current=$(pactl get-sink-volume "$sink" | awk -F'/' '{print $2}' | tr -d ' %')

case "$direction" in
  mute)
    pactl set-sink-mute "$sink" toggle
    ;;
  down)
    if [ "$current" -le 10 ]; then
      pactl set-sink-volume "$sink" -1%
    else
      pactl set-sink-volume "$sink" -5%
    fi
    ;;
  up)
    if [ "$current" -lt 10 ]; then
      pactl set-sink-volume "$sink" +1%
    else
      pactl set-sink-volume "$sink" +5%
    fi
    ;;
  *)
    echo "Usage: $0 {mute|down|up}"
    exit 1
    ;;
esac

pkill -USR1 -x i3status

