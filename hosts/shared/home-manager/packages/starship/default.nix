# Cool graphic on terminal open

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    starship 
  ];

  home.file = {
    ".config/starship.toml" = {
      source = ./starship.toml;
      recursive = false;
    };
  };
}
