# cat replacement

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop 
  ];

  home.file = {
    ".config/btop" = {
      source = ../btop;
      recursive = true;
    };
  };
}
