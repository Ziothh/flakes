{ pkgs, ... }:

{
  imports = [
    ./hyprpaper
  ];

  home.packages = with pkgs; [
    # Is already installed via ~/.config/flakes/configuration.nix
  ];

  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = ./hyprland.conf;
      recursive = false;
    };
  };
}
