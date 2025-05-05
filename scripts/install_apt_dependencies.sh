#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No dependencies passed. Exiting..."
    exit 1
fi

echo "Updating package list..."
sudo apt update

echo "Installing dependencies: $@"
sudo apt install -y "$@"

echo "Dependencies installed successfully!"

