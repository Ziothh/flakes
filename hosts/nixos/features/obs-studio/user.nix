# Config for my window manager and all wayland specific applications

{ pkgs, ... }:

{
  # imports = [
  # ];

  home.packages = with pkgs; [
    pipewire # Used as a video input source
    obs-studio # Screen recording
  ];

  # home.file = {
    # ".config/electron-flags.conf" = {
    #   source = ./electron-flags.conf;
    #   recursive = false;
    # };
  # };
}
