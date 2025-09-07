#!/bin/bash

us="xkb:us:intl:eng"
es="xkb:es::spa"

current=$(ibus engine)

if [[ "$current" == "$us" ]]; then
    ibus engine "$es"
else
    ibus engine "$us"
fi

pkill -USR1 -x i3status

