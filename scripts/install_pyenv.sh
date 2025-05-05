#!/bin/bash

if [ -d "$HOME/.pyenv" ]; then
    echo "pyenv is already installed. Skipping installation."
else
    echo "pyenv not found. Installing..."
    curl -fsSL https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc
fi

