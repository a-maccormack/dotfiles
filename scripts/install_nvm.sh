#!/bin/bash

if command -v nvm &> /dev/null || [[ -d "$HOME/.nvm" ]]; then
  echo "NVM is already installed. Skipping installation."
else
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

