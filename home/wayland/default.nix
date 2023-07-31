{ pkgs, ... }:

{
  imports = [
    ./hypr
    ./waybar
    ./swaync
    ./tofi
    ./wlogout
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
