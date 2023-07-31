# A bar for wayland

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar 
  ];

  home.file = {
    ".config/waybar" = {
      source = ../waybar;
      recursive = true;
    };
  };
}
