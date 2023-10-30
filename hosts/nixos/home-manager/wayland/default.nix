# Config for my window manager and all wayland specific applications

{ pkgs, ... }:

{
  imports = [
    ./grim # Screenshot tool
    ./hyprland # Wayland compositor
    ./rofi # Spotlight for wayland
    ./swappy # Snapshot editor tool
    ./waybar # Interactive bar
    ./swaync
    ./tofi
    ./wlogout # Logout screen
    ./wofi
  ];

  home.packages = with pkgs; [
    # Wayland is already installed via ~/.config/flakes/configuration.nix
  ];

  home.file = {
    ".config/electron-flags.conf" = {
      source = ./electron-flags.conf;
      recursive = false;
    };
  };
}
