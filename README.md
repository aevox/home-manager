# home-manager configuration

This repository should be cloned as ~/.config/home-manager/

## Install

### Nix

install nix:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Nixpkgs channel

add channel nixpkgs-unstable:

```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

on non nixos systems, add:

```bash
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl
nix-channel --update
```

### home-manager

install home-manager:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

## Uninstall everything

```bash
home-manager uninstall
sudo systemctl stop nix-daemon.service
sudo systemctl disable nix-daemon.socket nix-daemon.service
sudo systemctl daemon-reload
sudo rm /etc/systemd/system/nix-daemon.service /etc/systemd/system/nix-daemon.socket
sudo rm /etc/tmpfiles.d/nix-daemon.conf
sudo rm -rf /nix /etc/nix /etc/profile/nix.sh ~root/.nix-profile ~root/.nix-defexpr ~root/.nix-channels ~/.nix-profile ~/.nix-defexpr ~/.nix-channels
for i in $(seq 1 32); do   sudo userdel nixbld$i; done
sudo groupdel nixbld
sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
sudo mv /etc/zsh.backup-before-nix /etc/zsh
```
