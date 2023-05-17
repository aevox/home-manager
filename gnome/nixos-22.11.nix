{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnomeExtensions.caffeine
  ];
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = lib.mkDefault {
      binding = "<Super>i";
      command = "rofi -show run";
      name = "rofi -show run";
    };
  };
}
