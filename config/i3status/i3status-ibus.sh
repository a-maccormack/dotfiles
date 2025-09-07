#!/bin/bash

i3status --config "$HOME/.config/i3status/config" | while read -r line; do
    if [[ "$line" == "{"* ]]; then
        echo "$line"
        continue
    fi

    if [[ "$line" == "[" ]]; then
        echo "$line"
        continue
    fi

    layout=$(ibus engine 2>/dev/null | awk -F: '{print toupper($2)}')

    if command -v pamixer >/dev/null 2>&1; then
        if pamixer --get-mute; then
            volume="MUTED"
        else
            volume="$(pamixer --get-volume)%"
        fi
    else
        raw=$(amixer get Master)
        if echo "$raw" | grep -q "\[off\]"; then
            volume="MUTED"
        else
            volume=$(echo "$raw" | awk -F'[][]' 'END{print $2}')
        fi
    fi

    brightness=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')
    brightness="${brightness}%"

    if [[ "$line" == ",["* ]]; then
        echo ",[{\"full_text\":\" $layout\",\"name\":\"layout\"},\
{\"full_text\":\" $volume\",\"name\":\"volume\"},\
{\"full_text\":\"☀ $brightness\",\"name\":\"brightness\"},${line:2}"
    else
        echo "[{\"full_text\":\" $layout\",\"name\":\"layout\"},\
{\"full_text\":\" $volume\",\"name\":\"volume\"},\
{\"full_text\":\"☀ $brightness\",\"name\":\"brightness\"},${line:1}"
    fi
done

