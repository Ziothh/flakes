# cat replacement

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty 
  ];

  home.file = {
    ".config/alacritty/alacritty.yml" = {
      source = ../alacritty/alacritty.yml;
      recursive = false;
    };
  };
}
