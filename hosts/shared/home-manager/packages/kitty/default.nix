{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  home.file = {
    ".config/kitty" = {
      source = ../kitty;
      recursive = true;
    };
  };
}
