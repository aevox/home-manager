{ config, pkgs, ... }:
let
  nixpkgs-gnome-tray-icons-reload-25 = import (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/c2c0373ae7abf25b7d69b2df05d3ef8014459ea3.tar.gz"; }) { };

  gnome-tray-icons-reloaded-25 = nixpkgs-gnome-tray-icons-reload-25.gnomeExtensions.tray-icons-reloaded;
in { home.packages = [ gnome-tray-icons-reloaded-25 ]; }
