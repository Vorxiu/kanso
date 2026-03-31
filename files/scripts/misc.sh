#!/usr/bin/env bash
set -euo pipefail

# create /nix mount point (read-only in the image layer)
mkdir -p /nix

rm /usr/share/applications/btop.desktop
rm /usr/share/applications/htop.desktop

sudo dnf install scdoc gzip -y 
# install app2unit
git clone https://github.com/Vladimir-csp/app2unit.git /tmp/app2unit
cd /tmp/app2unit
sudo make install

# install niri-settings
git clone https://github.com/stefonarch/niri-settings.git /tmp/niri-settings
cd /tmp/niri-settings
echo "Installing to system..."
# Install binary and .desktop file
sudo cp -v niri-settings /usr/bin/niri-settings
sudo chmod a+x /usr/bin/niri-settings
sudo cp -v niri-settings.desktop /usr/share/applications/niri-settings.desktop

# Install python files
sudo mkdir -p /usr/lib/niri-settings/ui
sudo cp -v niri_settings.py /usr/lib/niri-settings/
sudo cp -av ui/*.py /usr/lib/niri-settings/ui

# Install translations to standard XDG data directory
sudo mkdir -p /usr/share/niri-settings/translations
sudo cp -av translations/*.qm /usr/share/niri-settings/translations/

# Icon
sudo cp -v niri-settings.svg /usr/share/icons/hicolor/scalable/apps/niri-settings.svg

echo ""
echo "Installation finished."
rm -rf /tmp/niri-settings

# nautilus extensions
echo "Installing Nautilus Code extension..."
sudo dnf install meson ninja -y
git clone --depth=1 https://github.com/realmazharhussain/nautilus-code.git /tmp/nautilus-code
cd /tmp/nautilus-code
meson setup build
meson install -C build

rm -rf /tmp/nautilus-code

sudo dnf remove scdoc meson ninja -y

