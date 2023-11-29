{ config, pkgs, lib, ... }:
let
    nixpkgs-2023-03-31 = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/1b7a6a6e57661d7d4e0775658930059b77ce94a4.tar.gz";
    }) {};

    pop-shell-2023-03-31 = nixpkgs-2023-03-31.gnomeExtensions.pop-shell;
in
{
  home.packages = with pkgs; [
    pop-launcher
    pop-gtk-theme
    pop-icon-theme
    gnomeExtensions.pop-launcher-super-key

    pop-shell-2023-03-31
  ];
}
