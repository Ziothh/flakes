# A screenshot tool for wayland

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
  ];

  # home.file = {
  #   ".config/swappy/config" = {
  #     source = ./swappy.conf;
  #     recursive = false;
  #   };
  # };
}
