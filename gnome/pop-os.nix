{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    gnomeExtensions.sound-output-device-chooser
  ];
}
