{ config, pkgs, ... }: {
  imports = [
    ../gnome/common.nix
    ../gnome/nixos-22.11.nix
  ];
  home.packages = with pkgs; [
    youtube-music
  ];
}
