{ config, pkgs, lib, ... }:
let
  nixpkgs-2023-01-13 = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/3c3b3ab88a34ff8026fc69cb78febb9ec9aedb16.tar.gz";
    }) {};

  caffeine-42 = nixpkgs-2023-01-13.gnomeExtensions.caffeine;
in {
  home.packages = with pkgs; [
    pop-launcher
    pop-gtk-theme
    pop-icon-theme
    gnomeExtensions.pop-launcher-super-key
    gnomeExtensions.pop-shell
    gnomeExtensions.sound-output-device-chooser
  ];
}
