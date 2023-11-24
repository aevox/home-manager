{ config, pkgs, lib, ... }: 
let
  nixpkgs-2023-03-11 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8.tar.gz";
  }) { };
  control-blur-19 = nixpkgs-2023-03-11.gnomeExtensions.control-blur-effect-on-lock-screen;
in {

  imports = [
    ../gnome/common.nix
  ];

  home.packages = with pkgs; [
    gnomeExtensions.space-bar
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.appindicator
    gnomeExtensions.impatience
    gnomeExtensions.caffeine
    control-blur-19
  ];
}
