#!/bin/bash
set -euo pipefail

I3_VERSION="4.24"
I3_URL="https://i3wm.org/downloads/i3-${I3_VERSION}.tar.xz"

if command -v i3 >/dev/null 2>&1; then
    echo "i3 is already installed: $(i3 --version)"
    exit 0
fi

echo "i3 not found, installing version ${I3_VERSION}..."

sudo apt-get update
sudo apt-get install -y \
    build-essential libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
    libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
    libxcb-randr0-dev libxcb-xinerama0-dev libxcb-shape0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
    libxcb-cursor-dev libxcb-xrm-dev libstartup-notification0-dev \
    libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev \
    libxcb-present-dev libxcb-sync-dev xutils-dev \
    automake autoconf meson ninja-build pkg-config flex bison curl libev-dev

TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"
curl -LO "$I3_URL"
tar -xf "i3-${I3_VERSION}.tar.xz"
cd "i3-${I3_VERSION}"

meson setup build --prefix=/usr
ninja -C build
sudo ninja -C build install

rm -rf "$TMP_DIR"
echo "i3 ${I3_VERSION} installed successfully."

