{ config, pkgs, lib, ... }:
let
  nixpkgs-2023-03-11 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8.tar.gz";
  }) { };
  control-blur-19 = nixpkgs-2023-03-11.gnomeExtensions.control-blur-effect-on-lock-screen;

  nixpkgs-2023-01-13 = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/3c3b3ab88a34ff8026fc69cb78febb9ec9aedb16.tar.gz";
    }) {};

  caffeine-42 = nixpkgs-2023-01-13.gnomeExtensions.caffeine;

  nixpkgs-2023-10-08 = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
    }) {};
  appindicator-53 = nixpkgs-2023-10-08.gnomeExtensions.appindicator;
  clipboald-indicator-47 = nixpkgs-2023-10-08.gnomeExtensions.clipboard-indicator;
  dash-to-panel-56 = nixpkgs-2023-10-08.gnomeExtensions.dash-to-panel;
  space-bar-22 = nixpkgs-2023-10-08.gnomeExtensions.space-bar;
in {
  imports = [
    ../gnome/common.nix
  ];

  home.packages = with pkgs; [
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.impatience

    #caffeine-42  # It tries to build it. We install caffeine without nix :(
    control-blur-19
    appindicator-53
    clipboald-indicator-47
    dash-to-panel-56
    space-bar-22
  ];
}
