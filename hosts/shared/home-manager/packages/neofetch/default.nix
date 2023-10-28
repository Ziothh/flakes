# Cool graphic on terminal open

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch 
  ];

  home.file = {
    ".config/neofetch" = {
      source = ../neofetch;
      recursive = true;
    };
  };
}
