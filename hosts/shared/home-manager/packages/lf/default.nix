{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    lf # File manager
  ] ++ lib.optionals stdenv.isLinux [
    ueberzug # Image viewing in terminal — Linux/X11 only
  ];

  home.file = {
    ".config/lf" = {
      source = ../lf;
      recursive = true;
    };
  };
}
