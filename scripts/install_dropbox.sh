#!/bin/bash

set -euo pipefail

echo "Checking for existing Dropbox installation..."

if [ -x "$HOME/.dropbox-dist/dropboxd" ]; then
  echo "Dropbox daemon already exists at ~/.dropbox-dist/dropboxd"

  if systemctl --user is-enabled dropbox.service &>/dev/null; then
    echo "Dropbox systemd service is already enabled."
    exit 0
  else
    echo "Dropbox daemon exists but service is not enabled. Proceeding to set up service..."
  fi
else
  echo "[1/5] Installing Dropbox daemon (headless)..."
  cd ~
  wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
  echo "Dropbox daemon installed."
fi

echo "[2/5] Creating systemd user service..."

mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/dropbox.service <<EOF
[Unit]
Description=Dropbox daemon
After=network.target

[Service]
ExecStart=%h/.dropbox-dist/dropboxd
Restart=on-failure
TimeoutStopSec=10
KillMode=process

[Install]
WantedBy=default.target
EOF

echo "Service file written to ~/.config/systemd/user/dropbox.service"

echo "[3/5] Reloading systemd user manager..."
systemctl --user daemon-reexec
systemctl --user daemon-reload

echo "[4/5] Enabling Dropbox systemd service..."
systemctl --user enable --now dropbox.service

echo "[5/5] Enabling user lingering for autostart..."
loginctl enable-linger "$USER"

echo "Dropbox is now installed, running in the background, and will start on login."

