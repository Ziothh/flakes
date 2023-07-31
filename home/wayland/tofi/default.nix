# A simple dmenu / rofi replacement for wlroots-based Wayland compositors such as Sway.

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tofi 
  ];

  home.file = {
    ".config/tofi" = {
      source = ../tofi;
      recursive = true;
    };
  };
}
