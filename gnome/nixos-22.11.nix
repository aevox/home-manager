{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    pop-launcher
    pop-gtk-theme
    pop-icon-theme
    gnomeExtensions.pop-launcher-super-key
    gnomeExtensions.pop-shell
    gnomeExtensions.caffeine
  ];
}
