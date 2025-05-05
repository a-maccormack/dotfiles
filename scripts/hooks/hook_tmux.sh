#!/bin/bash

TMUX_CHECK='exec tmux'

if ! grep -q "$TMUX_CHECK" "$HOME/.zshrc"; then
    echo "Adding tmux autostart check to .zshrc..."

    echo '
# Tmux autostart
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    exec tmux
fi' >> "$HOME/.zshrc"

    echo "Tmux autostart check added to .zshrc."
else
    echo "Tmux autostart check already present in .zshrc. Skipping addition."
fi

