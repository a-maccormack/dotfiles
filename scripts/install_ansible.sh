#!/bin/bash

if ! command -v pipx >/dev/null 2>&1; then
  echo "pipx is not installed. Please install pipx first."
  exit 1
fi

if pipx list | grep -q "package ansible"; then
  echo "Ansible is already installed via pipx."
  exit 0
fi

echo "Installing Ansible with pipx..."
pipx install --include-deps ansible

if command -v ansible >/dev/null 2>&1; then
  echo "Ansible was successfully installed."
else
  echo "Ansible installation failed."
fi

