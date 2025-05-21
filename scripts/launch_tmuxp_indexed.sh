#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/tmuxp"
CHOOSER="fzf"

if ! command -v fzf &>/dev/null; then
  tmux display-message "fzf not found"
  exit 1
fi

CONFIG=$(ls "$CONFIG_DIR" | sed 's/\.ya\?ml$//' | fzf --prompt="Choose tmuxp config: ")
[ -z "$CONFIG" ] && exit 0

for i in $(seq 1 9); do
  if ! tmux has-session -t "$i" 2>/dev/null; then
    tmux display-message "Launching $CONFIG as session $i..."

    # Launch tmuxp directly using numeric name
    tmuxp load -y -s "$i" "$CONFIG_DIR/$CONFIG.yaml"

    # Attach to the newly created session
    tmux switch-client -t "$i"
    break
  fi
done

