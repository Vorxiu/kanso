# ublue-niri &nbsp; [![bluebuild build badge](https://github.com/vorxiu/ublue-niri/actions/workflows/build.yml/badge.svg)](https://github.com/vorxiu/ublue-niri/actions/workflows/build.yml)

A base niri image with noctalia-shell for an OOTB experience
Full package list [here](https://github.com/Vorxiu/ublue-niri/blob/main/recipes/recipe.yml)

- CachyOS kernel
- Minimal dotfiles for niri,noctalia,zsh,kitty
- Bazaar included
- ujust recipes run `ujust`

## Installation

- Disable secure boot and on any atomic distro with bootc run
```bash
bootc switch ghcr.io/vorxiu/ublue-niri:latest
systemctl reboot
```
- Enroll the MOK key into MOK manager with password `universalblue`
- Re enable secure boot

The `latest` tag will automatically point to the latest build.

## ISO &nbsp; [![build-iso](https://github.com/Vorxiu/ublue-niri/actions/workflows/build-iso.yml/badge.svg)](https://github.com/Vorxiu/ublue-niri/actions/workflows/build-iso.yml)

Currently you can download the ISO from the latest [GitHub Actions workflow run](https://github.com/Vorxiu/ublue-niri/actions/workflows/build-iso.yml).

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/vorxiu/ublue-niri
```

#### FIX VS CODE FONTS AND ICONS

```bash
ujust fix-fonts
```

#### Manually import secure boot certificate into mok manager

```bash
ujust enroll-secure-boot-key  

```

reboot 

> Mok password : universalblue
