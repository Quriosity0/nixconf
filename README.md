# Quriosity's nixconf

![Lang](https://img.shields.io/github/languages/top/Quriosity0/nixconf)
![License](https://img.shields.io/github/license/Quriosity0/nixconf)
![Release](https://img.shields.io/github/v/release/Quriosity0/nixconf)

My personal configuration files for **NixOS** Linux (system + Home manager, built with flakes)

## Requirements

- [NixOS](https://nixos.org/) ***unstable*** with flakes enabled
- [home-manager](https://github.com/nix-community/home-manager)

## Installation and updating (UNSTABLE)

> ### **NOTE:**

> **Nix Flakes** is an experimental feature. To enable flakes, when rebuilding system add `--experimental-features 'nix-command flakes'` flag

> Unfree repository is **disabled** by default. To allow NixOS unfree packages, use `NIXPKGS_ALLOW_UNFREE=1`

> This repository is tested only on **official NixOS Unstable channel**! Any other channel may cause bugs or build errors! 

### Installing

```bash
git clone https://github.com/Quriosity0/nixconf.git ~/nixconf
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
NIXPKGS_ALLOW_UNFREE=1 sudo nixos-rebuild switch --flake /path/to/nixconf#asuspc --experimental-features 'nix-command flakes'
sudo reboot
```

After reboot you can update your system and home-manager configuration with one command

```bash
update
```

If needed, clean every old generation:

```bash
clean-gens
```

### Updating

When you want to update config to the latest commit, just do the pull inside the cloned folder and rerun all commands above (except git clone)

```bash
git pull
update
```

> **NOTE:** `asuspc` & `quriosity` — names of my PC and profile, given in every configuration file in this repo. If you change them on your machine, then change them in command alias

## Licnese

This project is freely distributed under the [GPL-3.0](LICENSE) license.
