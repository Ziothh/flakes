# cat replacement

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zellij
  ];

  home.file = {
    ".config/zellij/config.kdl" = {
      source = ./config.kdl;
      recursive = true;
    };
  };
}
