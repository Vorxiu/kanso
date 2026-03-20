#!/usr/bin/env bash
set -euo pipefail

# create /nix mount point (read-only in the image layer)
mkdir -p /nix

rm /usr/share/applications/btop.desktop

git clone https://github.com/Vladimir-csp/app2unit.git /app2unit
cd /app2unit
make
sudo make install
cd ..
rm -rf app2unit