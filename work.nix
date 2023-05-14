{ config, pkgs, ... }:
let
  nixgl = import <nixgl> {};
in {

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

