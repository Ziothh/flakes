# Home manager config for NixOS

{ pkgs, ... }:
{
  imports = [
  ];

  home.packages = with pkgs; [
    sequelpro
  ];
}
