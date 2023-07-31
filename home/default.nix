# Home manager config for NixOS

{ pkgs, ... }:
{
  imports = [
    ./wayland
  ];

  home.packages = with pkgs; [
    rofi # Spotlight
  ];
}
