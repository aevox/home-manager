{ config, pkgs, ... }:
let
  nixgl = import <nixgl> {};
in {
  imports = [
    ../gnome/gnome-42.nix
    ../gnome/pop-shell.nix
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
    exec = "nixGLIntel alacritty %u";
    icon = "Alacritty";
  };
  xdg.desktopEntries.kitty = {
    name = "kitty";
    exec = "nixGLIntel kitty %u";
    icon = "kitty";
  };
  xdg.desktopEntries."com.github.eneshecan.WhatsAppForLinux" = {
    name = "WhatsAppForLinux";
    exec = "nixGLIntel whatsapp-for-linux %u";
    icon = "com.github.eneshecan.WhatsAppForLinux";
  };
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "/usr/bin/kitty";
      name = "open-terminal";
    };
  };
}

