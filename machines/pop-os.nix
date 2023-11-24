{ config, pkgs, ... }:
let
  nixgl = import <nixgl> {};
in {
  imports = [
    ../gnome/gnome-42.nix
  ];

  home.username = "marc";
  home.homeDirectory = "/home/marc";

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
