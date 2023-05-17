{ config, pkgs, lib, ... }:
let
  nixpkgs-2023-01-13 = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/3c3b3ab88a34ff8026fc69cb78febb9ec9aedb16.tar.gz";
    }) {};

  caffeine-42 = nixpkgs-2023-01-13.gnomeExtensions.caffeine;
in {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnomeExtensions.sound-output-device-chooser
  ];
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = lib.mkDefault {
      binding = "<Super>i";
      command = "rofi -show run";
      name = "rofi -show run";
    };
  };
}
