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

    if [[ "$line" == ",["* ]]; then
        echo ",[{\"full_text\":\" $layout\",\"name\":\"layout\"},${line:2}"
    else
        echo "[{\"full_text\":\" $layout\",\"name\":\"layout\"},${line:1}"
    fi
done

