{ pkgs, ... }:

{
  imports = [
    ./hyprpaper
  ];

  home.packages = with pkgs; [
    # Is already installed via ../configuration.nix
  ];

  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = ./hyprland.conf;
      recursive = false;
    };
  };
}
