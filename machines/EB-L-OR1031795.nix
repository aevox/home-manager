{ config, pkgs, ... }:
let
  nixgl = import <nixgl> {};
  nixpkgs-2022-09-15 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/c2c0373ae7abf25b7d69b2df05d3ef8014459ea3.tar.gz";
  }) { };
in {
  imports = [
    ../gnome/common.nix
    ../gnome/gnome-42.nix
  ];

  home.username = "knwk3963";
  home.homeDirectory = "/home/knwk3963";

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    nixgl.nixGLIntel
  ];

  programs.git.userEmail = "marc.fouche@orange.com";

  xdg.desktopEntries.Alacritty = {
    name = "Alacritty";
    exec = "nixGLIntel alacritty";
    icon = "Alacritty";
  };
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "nixGLIntel alacritty";
      name = "open-terminal";
    };
  };
}

