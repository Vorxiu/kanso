install-vscode:
    #!/usr/bin/env bash
    set -euxo pipefail
    brew tap ublue-os/tap
    brew install --cask visual-studio-code-linux
    echo "Installing VSCode extensions"
    code --install-extension ms-vscode-remote.remote-containersa
    code --install-extension ms-vscode-remote.remote-ssh
    code --install-extension ms-azuretools.vscode-containers
    cp -rn /etc/skel/.config/Code/User/settings.json ~/.config/Code/User/settings.json
    ujust fix-fonts

install-jetbrains-toolbox:
    #!/usr/bin/env bash
    set -euxo pipefail
    brew tap ublue-os/tap
    brew install --cask jetbrains-toolbox-linux

fix-fonts:
    #!/usr/bin/env bash
    set -euxo pipefail
    fc-cache -f -v ~/.local/share/fonts ~/.fonts
    rm -rf ~/.cache/fontconfig/*
    fc-cache -f -v
    sudo fc-cache -f -v /usr/share/fonts /usr/local/share/fonts

install-default-configs:
    #!/usr/bin/env bash
    set -euxo pipefail
    chezmoi update --no-tty --force
    cp -rn /etc/skel/.config/Code/User/settings.json ~/.config/Code/User/settings.json

fix-gtk-theming:
    #!/usr/bin/env bash
    set -euxo pipefail
    flatpak install org.gtk.Gtk3theme.adw-gtk3-dark
    flatpak install org.gtk.Gtk3theme.adw-gtk3
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    echo "You might want to refresh the gtk template from colorscheme -> templates in noctalia settings"
