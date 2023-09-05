# Wallpaper for hyprland (wayland)

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file = {
    ".config/hypr/hyprpaper.conf" = {
      source = ./hyprpaper.conf;
      recursive = false;
    };
    ".config/hypr/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };
}
