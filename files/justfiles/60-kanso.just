# intalls visual studio code from the ublue tap.
install-vscode:
    #!/usr/bin/env bash
    set -euxo pipefail
    brew tap ublue-os/tap
    brew install --cask visual-studio-code-linux
    echo "Installing VSCode extensions"
    code --install-extension ms-vscode-remote.remote-containers
    code --install-extension ms-vscode-remote.remote-ssh
    code --install-extension ms-azuretools.vscode-containers
    cp -rn /etc/skel/.config/Code/User/settings.json ~/.config/Code/User/settings.json
    ujust fix-fonts

# install jetbrains toolbox from the ublue tap, which is needed to install intellij and pycharm
install-jetbrains-toolbox:
    #!/usr/bin/env bash
    set -euxo pipefail
    brew tap ublue-os/tap
    brew install --cask jetbrains-toolbox-linux

# install zed editor from the official install script.
install-zed:
    #!/usr/bin/env bash
    set -euxo pipefail
    curl -f https://zed.dev/install.sh | sh

# Installs brave origin using rpm-ostree
install-brave-origin:
    #!/usr/bin/env bash
    set -euxo pipefail
    run0 curl -fsSLo /etc/yum.repos.d/brave-browser-nightly.repo https://brave-browser-rpm-nightly.s3.brave.com/brave-browser-nightly.repo
    run0 rpm-ostree install brave-origin-nightly

# fix font issues with vscode.
fix-fonts:
    #!/usr/bin/env bash
    set -euxo pipefail
    fc-cache -f -v ~/.local/share/fonts ~/.fonts
    rm -rf ~/.cache/fontconfig/*
    fc-cache -f -v
    sudo fc-cache -f -v /usr/share/fonts /usr/local/share/fonts

# force installs the default dotfiles
install-default-configs:
    #!/usr/bin/env bash
    set -euxo pipefail
    systemctl enable --user --now chezmoi-init.service chezmoi-update.timer
    chezmoi update --no-tty --force
    cp -rn /etc/skel/.config/Code/User/settings.json ~/.config/Code/User/settings.json

# fix gtk theming
fix-gtk-theming:
    #!/usr/bin/env bash
    set -euxo pipefail
    flatpak install org.gtk.Gtk3theme.adw-gtk3-dark
    flatpak install org.gtk.Gtk3theme.adw-gtk3
    pkexec flatpak override --filesystem=xdg-config/gtk-3.0:rw
    pkexec flatpak override --filesystem=xdg-config/gtk-4.0:rw
    rm ~/.config/gtk-4.0/gtk.css && rm ~/.config/gtk-4.0/gtk-dark.css
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    cp /usr/share/themes/adw-gtk3-dark/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
    cp /usr/share/themes/adw-gtk3/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
    ln -s /usr/share/themes/adw-gtk3-dark/gtk-4.0/libadwaita-tweaks.css libadwaita-tweaks.css
    ln -s /usr/share/themes/adw-gtk3-dark/gtk-4.0/libadwaita.css libadwaita.css
    echo "@import url('noctalia.css') ;" >> ~/.config/gtk-4.0/gtk-dark.css
    echo "@import url('noctalia.css') ;" >> ~/.config/gtk-4.0/gtk.css
    echo "You might want to refresh the gtk template from colorscheme -> templates in noctalia settings"

# configure groups for docker, incus, libvirt, and dialout to avoid needing sudo for those.
[group('System')]
dx-group:
    #!/usr/bin/pkexec bash
    append_group() {
        local group_name="$1"
        if ! grep -q "^$group_name:" /etc/group; then
            echo "Appending $group_name to /etc/group"
            grep "^$group_name:" /usr/lib/group | sudo tee -a /etc/group > /dev/null
        fi
    }
    GROUPS_ADD=("docker" "incus-admin" "libvirt" "dialout")
    for GROUP_ADD in "${GROUPS_ADD[@]}" ; do
        append_group $GROUP_ADD
        usermod -aG $GROUP_ADD {{ `id -un` }}
    done

    echo "Reboot system and log back in to use docker, libvirt, incus, and serial connections."

# enable auto login for greetd recommended when using luks encryption to avoid having to enter the password twice.
[group('System')]
enable-auto-login:
    #!/usr/bin/bash
    set -euxo pipefail
    CURRENT_USER="$(id -un)"
    if ! grep -q '^\[initial_session\]' /etc/greetd/config.toml; then
        printf '\n[initial_session]\ncommand = "niri-session"\nuser = "%s"\n' "$CURRENT_USER" | pkexec tee -a /etc/greetd/config.toml
        echo "Auto login enabled for user $CURRENT_USER. Reboot to apply changes."
    fi
