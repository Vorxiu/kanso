#!/usr/bin/env bash
set -euo pipefail

# create /nix mount point (read-only in the image layer)
mkdir -p /nix

rm /usr/share/applications/btop.desktop
rm /usr/share/applications/htop.desktop

# remove repos from the image
rm /etc/yum.repos.d/docker-ce.repo
rm /etc/yum.repos.d/niri-git-blur.repo

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

cd / 

# install to a writable location
sudo mkdir -p /etc/sddm/themes/sddm-noctalia
git clone https://github.com/vorxiu/sddm-noctalia.git /tmp/sddm-noctalia
sudo cp -r /tmp/sddm-noctalia /etc/sddm/themes/sddm-noctalia
# make the config file writable by noctalia
sudo chmod 666 /etc/sddm/themes/sddm-noctalia/*.conf
rm -rf /tmp/sddm-noctalia