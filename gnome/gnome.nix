{ config, pkgs, ... }: 
let
  nixpkgs-gnome-tray-icons-reload-25 = import (builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/c2c0373ae7abf25b7d69b2df05d3ef8014459ea3.tar.gz";
  }) { };
  gnome-tray-icons-reloaded-25 =
    nixpkgs-gnome-tray-icons-reload-25.gnomeExtensions.tray-icons-reloaded;

  nixgl = import <nixgl> {};
in {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnomeExtensions.space-bar
    gnomeExtensions.rounded-window-corners
  ]
  ++ (if builtins.getEnv "HOME" == "/home/knwk3963" then
        [ gnome-tray-icons-reloaded-25 ]
      else
        [ gnomeExtensions.tray-icons-reloaded ]);

  dconf.settings = {
    "org/gnome/shell/extensions/pop-shell" = {
      activate-launcher = [];
      focus-left = ["<Super>t" "<Super>Left"];
      focus-down = ["<Super>s" "<Super>Down"];
      focus-up = ["<Super>r" "<Super>Up"];
      focus-right = ["<Super>n" "<Super>Right"];

      tile-enter = ["<Super>b"];
      tile-accept = ["Return" "<Super>b" "b"];
      tile-move-left = ["t" "Left"];
      tile-move-down = ["s" "Down"];
      tile-move-up = ["r" "Up"];
      tile-move-right = ["n" "Right"];

      tile-move-left-global = ["<Super><Shift>t" "<Super><Shift>Left"];
      tile-move-down-global = ["<Super><Shift>s" "<Super><Shift>Down"];
      tile-move-up-global = ["<Super><Shift>r" "<Super><Shift>Up"];
      tile-move-right-global = ["<Super><Shift>n" "<Super><Shift>Right"];

      toggle-stacking-global = ["<Super>u"];
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = ["<Super>e"];
      close = ["<Super>q" "<Alt>F4"];
    };
    "org/gnome/shell/extensions/space-bar/behavior" = {
      show-empty-workspaces = false;
      smart-workspace-names = true;
    };
    "org/gnome/shell/extensions/space-bar/shortcuts" = {
      enable-activate-workspace-shortcuts = true;
      enable-move-to-workspace-shortcuts = true;
    };
  };
}
