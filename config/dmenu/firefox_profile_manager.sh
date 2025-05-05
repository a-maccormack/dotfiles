#!/bin/bash

source ~/.zshrc

URL="$1"

if [[ -n "$URL" ]]; then
    exec firefox-base --no-remote -P "$PROFILE" --new-tab "$@"
else
    exec firefox-base --no-remote -P "$PROFILE"
fi

