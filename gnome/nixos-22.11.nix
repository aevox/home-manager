{ config, pkgs, lib, ... }:
let
  nixpkgs-2023-03-11 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8.tar.gz";
  }) { };

  tray-icons-reloaded-26 = nixpkgs-2023-03-11.gnomeExtensions.tray-icons-reloaded;
in {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    tray-icons-reloaded-26
    gnomeExtensions.caffeine
  ];
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = lib.mkDefault {
      binding = "<Super>i";
      command = "rofi -show run";
      name = "rofi -show run";
    };
  };
}
