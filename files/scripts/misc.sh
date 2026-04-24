#!/usr/bin/env bash
set -euo pipefail

# create /nix mount point (read-only in the image layer)
mkdir -p /nix

rm /usr/share/applications/btop.desktop || true
rm /usr/share/applications/htop.desktop || true

# remove repos from the image
rm /etc/yum.repos.d/docker-ce.repo || true
rm /etc/yum.repos.d/niri-git.repo || true

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
sudo cp -a /tmp/sddm-noctalia/. /etc/sddm/themes/sddm-noctalia/
ls -l /etc/sddm/themes/sddm-noctalia/
sudo chmod 666 /etc/sddm/themes/sddm-noctalia/template.conf
sudo chmod 666 /etc/sddm/themes/sddm-noctalia/theme.conf

rm -rf /tmp/sddm-noctalia


# zsh plugin cache for zinit
# mkdir -p /etc/skel/.local/share/zinit/plugins
# mkdir -p /etc/skel/.local/share/zinit

mkdir -p /usr/share/icons
wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C /usr/share/icons

# git clone https://github.com/Aloxaf/fzf-tab.git /etc/skel/.local/share/zinit/plugins/Aloxaf---fzf-tab
# git clone https://github.com/MichaelAquilina/zsh-auto-notify.git /etc/skel/.local/share/zinit/plugins/MichaelAquilina---zsh-auto-notify
# git clone https://github.com/RobSis/zsh-completion-generator.git /etc/skel/.local/share/zinit/plugins/RobSis---zsh-completion-generator
# git clone https://github.com/aubreypwd/zsh-plugin-require.git /etc/skel/.local/share/zinit/plugins/aubreypwd---zsh-plugin-require
# git clone https://github.com/jeffreytse/zsh-vi-mode.git /etc/skel/.local/share/zinit/plugins/jeffreytse---zsh-vi-mode
# git clone https://github.com/marlonrichert/zsh-autocomplete.git /etc/skel/.local/share/zinit/plugins/marlonrichert---zsh-autocomplete
# git clone https://github.com/redxtech/zsh-kitty.git /etc/skel/.local/share/zinit/plugins/redxtech---zsh-kitty
# git clone https://github.com/romkatv/powerlevel10k.git /etc/skel/.local/share/zinit/plugins/romkatv---powerlevel10k
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git /etc/skel/.local/share/zinit/plugins/zdharma-continuum---fast-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions.git /etc/skel/.local/share/zinit/plugins/zsh-users---zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-completions.git /etc/skel/.local/share/zinit/plugins/zsh-users---zsh-completions
# git clone https://github.com/zsh-users/zsh-history-substring-search.git /etc/skel/.local/share/zinit/plugins/zsh-users---zsh-history-substring-search
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /etc/skel/.local/share/zinit/plugins/zsh-users---zsh-syntax-highlighting
# git clone https://github.com/zdharma-continuum/zinit.git /etc/skel/.local/share/zinit/zinit.git