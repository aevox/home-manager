{ config, pkgs, ... }: {
  imports = [
    ../gnome/gnome-44.nix
    ../gnome/pop-shell.nix
  ];
  home.packages = with pkgs; [
    youtube-music
  ];
}
