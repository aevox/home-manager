{ config, pkgs, lib, ... }:
let
  nixpkgs-gnome-tray-icons-reload-25 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/c2c0373ae7abf25b7d69b2df05d3ef8014459ea3.tar.gz";
  }) { };
  gnome-tray-icons-reloaded-25 =
    nixpkgs-gnome-tray-icons-reload-25.gnomeExtensions.tray-icons-reloaded;

  nixpkgs-gnome-tray-icons-reload-26 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8.tar.gz";
  }) { };
  gnome-tray-icons-reloaded-26 =
    nixpkgs-gnome-tray-icons-reload-26.gnomeExtensions.tray-icons-reloaded;
in {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnomeExtensions.space-bar
    gnomeExtensions.rounded-window-corners
  ]
  ++ (if builtins.getEnv "HOME" == "/home/knwk3963" then
        [ gnome-tray-icons-reloaded-25 ]
      else
        [ gnome-tray-icons-reloaded-26 ]);

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
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 12;
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = ["<Super>e"];
      close = ["<Super>q" "<Alt>F4"];

      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];
      switch-to-workspace-11 = ["<Super>equal"];
      switch-to-workspace-12 = ["<Super>grave"];
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
      move-to-workspace-10 = ["<Super><Shift>0"];
      move-to-workspace-11 = ["<Super><Shift>equal"];
      move-to-workspace-12 = ["<Super><Shift>grave"];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = ["<Alt>1"];
      switch-to-application-2 = ["<Alt>2"];
      switch-to-application-3 = ["<Alt>3"];
      switch-to-application-4 = ["<Alt>4"];
      switch-to-application-5 = ["<Alt>5"];
      switch-to-application-6 = ["<Alt>6"];
      switch-to-application-7 = ["<Alt>7"];
      switch-to-application-8 = ["<Alt>8"];
      switch-to-application-9 = ["<Alt>9"];
      toggle-application-view = ["<Super>a"];
      toggle-message-tray = ["<Super>v"];
      toggle-overview = [];
      focus-active-notification = [];
      open-applaction-menu = [];
    };
    "org/gnome/shell/overrides" = {
      dynamic-workspaces = false;
    };
    "org/gnome/shell/extensions/space-bar/behavior" = {
      show-empty-workspaces = false;
      smart-workspace-names = true;
    };
    "org/gnome/shell/extensions/space-bar/shortcuts" = {
      enable-activate-workspace-shortcuts = false;
      enable-move-to-workspace-shortcuts = false;
      activate-previous-keys = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = lib.mkDefault {
      binding = "<Super>Return";
      command = "alacritty";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = lib.mkDefault {
      binding = "<Super>i";
      command = "rofi -show run";
      name = "rofi -show run";
    };
  };
}
