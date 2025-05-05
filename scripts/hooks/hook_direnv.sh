#!/bin/bash

ZSHRC="$HOME/.zshrc"
DIRENV_HOOK='eval "$(direnv hook zsh)"'

if grep -q "direnv" "$ZSHRC"; then
  echo "A direnv hook already exists in .zshrc. Skipping."
else
  echo "Adding direnv hook to .zshrc..."
  echo "$DIRENV_HOOK" >> "$ZSHRC"
  echo "Done. Please restart your terminal or run: source ~/.zshrc"
fi

