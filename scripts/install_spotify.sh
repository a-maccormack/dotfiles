#!/usr/bin/env bash

set -e

if dpkg -s spotify-client &>/dev/null; then
  echo "Spotify is already installed. Skipping."
  exit 0
fi

echo "Spotify is not installed. Proceeding with installation..."

KEY_PATH="/etc/apt/trusted.gpg.d/spotify.gpg"
if [ ! -f "$KEY_PATH" ]; then
  echo "Adding Spotify GPG key..."
  curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg \
    | sudo gpg --dearmor --yes -o "$KEY_PATH"
else
  echo "Spotify GPG key already exists. Skipping."
fi

REPO_LINE="deb https://repository.spotify.com stable non-free"
LIST_FILE="/etc/apt/sources.list.d/spotify.list"

if ! grep -Fxq "$REPO_LINE" "$LIST_FILE" 2>/dev/null; then
  echo "Adding Spotify APT repository..."
  echo "$REPO_LINE" | sudo tee "$LIST_FILE" > /dev/null
else
  echo "Spotify APT repository already exists. Skipping."
fi

echo "Updating package index and installing Spotify..."
sudo apt-get update
sudo apt-get install -y spotify-client

echo "Spotify installation complete."

