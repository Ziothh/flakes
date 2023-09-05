# Config for my window manager and all wayland specific applications

{ pkgs, ... }:

{
  imports = [
    ./hypr # Wayland compositor
    ./waybar # Interactive bar
    ./swaync
    ./tofi
    ./wlogout # Logout screen
    ./wofi
  ];

  home.packages = with pkgs; [
    # Is already installed via ~/.config/flakes/configuration.nix
  ];

  home.file = {
    ".config/electron-flags.conf" = {
      source = ./electron-flags.conf;
      recursive = false;
    };
  };
}
