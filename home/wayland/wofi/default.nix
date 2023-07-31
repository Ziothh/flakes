# A simple dmenu / rofi replacement for wlroots-based Wayland compositors such as Sway.

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi 
  ];

  home.file = {
    ".config/wofi" = {
      source = ../wofi;
      recursive = true;
    };
  };
}
