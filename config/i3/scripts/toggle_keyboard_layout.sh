#!/bin/bash

CURRENT_LAYOUT=$(setxkbmap -query | awk '/layout/ {print $2}')
if [ "$CURRENT_LAYOUT" = "es" ]; then
  setxkbmap -layout us -variant intl
else
  setxkbmap -layout es
fi

