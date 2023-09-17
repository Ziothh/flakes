# Home manager config for NixOS

{ pkgs, ... }:
{
  imports = [
    ./obs-studio
    ./wayland
  ];

  home.packages = with pkgs; [
    discord
  ];
}
