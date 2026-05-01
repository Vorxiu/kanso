# Kanso-linux &nbsp; [![bluebuild build badge](https://github.com/vorxiu/ublue-niri/actions/workflows/build.yml/badge.svg)](https://github.com/vorxiu/ublue-niri/actions/workflows/build.yml)
![Screenshot 1](Screenshots/1.png)

An opinionated Niri Wayland compositor image with noctalia-shell and Cachyos kernel built on Universal Blue using bluebuild.


dot files for the image are [here](https://github.com/Vorxiu/niri-dots).
## Installation

- Disable secure boot and on any atomic distro with bootc run
```bash
bootc switch ghcr.io/vorxiu/kanso:latest
systemctl reboot
```
- Enroll the MOK key into MOK manager with password `universalblue`
- Re enable secure boot

The `latest` tag will automatically point to the latest build.

## ISO &nbsp; [![build-iso](https://github.com/Vorxiu/kanso/actions/workflows/build-iso.yml/badge.svg)](https://github.com/Vorxiu/kanso/actions/workflows/build-iso.yml)

Currently you can download the ISO from the latest [GitHub Actions workflow run](https://github.com/Vorxiu/kanso/actions/workflows/build-iso.yml).

#### **Downloads are also available on sourceforge**

<a href="https://sourceforge.net/projects/kanso/files/latest/download">
<img alt="Download from sourceforge" src="https://a.fsdn.com/con/app/sf-download-button">
</a>


## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/Vorxiu/kanso
```

## Screenshots

![Screenshot 2](Screenshots/2.png)
![Screenshot 3](Screenshots/3.png)


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
