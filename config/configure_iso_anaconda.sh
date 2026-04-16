#!/usr/bin/env bash
set -eoux pipefail

# Remove packages to save space
dnf remove -y google-noto-fonts-all ublue-brew || true

# Configure GNOME defaults for live session
tee /usr/share/glib-2.0/schemas/zz2-org.gnome.shell.gschema.override <<EOF
[org.gnome.shell]
favorite-apps = ['anaconda.desktop', 'org.mozilla.firefox.desktop', 'org.gnome.Nautilus.desktop']
EOF

glib-compile-schemas /usr/share/glib-2.0/schemas

# Disable services not needed in live environment
systemctl disable rpm-ostree-countme.service
systemctl disable tailscaled.service
systemctl disable bootloader-update.service

# Install Anaconda for installation
dnf install -y anaconda-live libblockdev-btrfs