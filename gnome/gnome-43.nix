{ config, pkgs, lib, ... }:
let
  nixpkgs-2023-03-11 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8.tar.gz";
  }) { };

  tray-icons-reloaded-26 = nixpkgs-2023-03-11.gnomeExtensions.tray-icons-reloaded;
in {
  home.packages = with pkgs; [
    tray-icons-reloaded-26
    gnomeExtensions.caffeine
  ];
}

