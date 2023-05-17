{ config, pkgs, lib, ... }:
let
  nixpkgs-2022-09-15 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/c2c0373ae7abf25b7d69b2df05d3ef8014459ea3.tar.gz";
  }) { };
  nixpkgs-2023-01-13 = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/3c3b3ab88a34ff8026fc69cb78febb9ec9aedb16.tar.gz";
    }) {};

  caffeine-42 = nixpkgs-2023-01-13.gnomeExtensions.caffeine;
  tray-icons-reloaded-25 = nixpkgs-2022-09-15.gnomeExtensions.tray-icons-reloaded;
in {
  home.packages = with pkgs; [
    tray-icons-reloaded-25
    gnomeExtensions.sound-output-device-chooser
  ];
}
