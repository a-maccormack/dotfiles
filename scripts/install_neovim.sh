#!/bin/bash

if ! [ -x "$(command -v nvim)" ]; then
    echo "Neovim not found. Downloading and installing..."

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

    tar -xvzf nvim-linux-x86_64.tar.gz

    sudo mv nvim-linux-x86_64 /opt/nvim

    sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

    rm -rf nvim-linux-x86_64.tar.gz
    rm -rf /opt/nvim/nvim-linux-x86_64

    DOTFILES_DIR=$(pwd)

    if [ ! -d "$DOTFILES_DIR" ]; then
        echo "Dotfiles directory not found! Please ensure you are in the correct directory."
        exit 1
    fi

    echo "Neovim installation and configuration setup complete."
else
    echo "Neovim is already installed. Skipping download."
fi

if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
    echo "Packer.nvim not found. Installing..."

    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    echo "Packer.nvim installation complete."
else
    echo "Packer.nvim is already installed. Skipping installation."
fi
