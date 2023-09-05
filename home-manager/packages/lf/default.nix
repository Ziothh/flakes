{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lf # File manager
      ueberzug # Image viewing in termnial
      # TODO: replace with xdragon
      # dragon-drop # Drag and drop functionality 
  ];

  home.file = {
    ".config/lf" = {
      source = ../lf;
      recursive = true;
    };
  };
}
