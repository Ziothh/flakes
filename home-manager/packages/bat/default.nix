# cat replacement

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat 
  ];

  home.file = {
    ".config/bat" = {
      source = ../bat;
      recursive = true;
    };
  };
}
