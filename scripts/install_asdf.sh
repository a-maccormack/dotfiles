#!/bin/bash

ASDF_BIN="/usr/bin/asdf"
ASDF_TAR_URL="https://github.com/asdf-vm/asdf/releases/download/v0.16.7/asdf-v0.16.7-linux-amd64.tar.gz"
ASDF_TAR_FILE="asdf-v0.16.7-linux-amd64.tar.gz"

if [ -f "$ASDF_BIN" ]; then
  echo "asdf is already installed at $ASDF_BIN"
  exit 0
fi

echo "Downloading asdf..."
curl -L "$ASDF_TAR_URL" -o "$ASDF_TAR_FILE"

echo "Extracting asdf..."
tar -xvzf "$ASDF_TAR_FILE"
rm "$ASDF_TAR_FILE"

echo "Moving asdf binary to /usr/bin..."
sudo mv asdf "$ASDF_BIN"
sudo chmod +x "$ASDF_BIN"

echo "asdf installation complete."

echo "installing elixir plugin on asdf"
asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git

echo "installing erlang plugin on asdf"
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git

echo "hooking asdf to .zshrc"
./scripts/hooks/hook_asdf.sh
