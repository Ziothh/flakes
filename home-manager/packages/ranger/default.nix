# File manager TUI

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ranger 
  ];

  home.file = {
    ".config/ranger" = {
      source = ../ranger;
      recursive = true;
    };
  };
}
