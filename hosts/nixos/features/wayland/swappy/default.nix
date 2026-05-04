# A snapshot editor tool for wayland

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swappy
  ];

  home.file = {
    ".config/swappy/config" = {
      source = ./swappy.conf;
      recursive = false;
    };
  };
}
