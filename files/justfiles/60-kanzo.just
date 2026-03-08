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

install-jetbrains:
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
    mkdir -p ~/.config/kitty
    mkdir -p ~/.config/niri
    cp -r /etc/xdg/kitty ~/.config/
    cp -r /etc/zsh/.zshrc ~/.zshrc
    cp -r /etc/niri/* ~/.config/niri/
    cp -rn /etc/skel/.config/Code/User/settings.json ~/.config/Code/User/settings.json
