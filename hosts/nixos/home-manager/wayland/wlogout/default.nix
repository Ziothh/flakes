# A simple dmenu / rofi replacement for wlroots-based Wayland compositors such as Sway.

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wlogout 
  ];

  home.file = {
    ".config/wlogout" = {
      source = ../wlogout;
      recursive = true;
    };
  };
}
