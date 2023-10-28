{ lib, pkgs, user, ... }:
{
  home.packages = with pkgs; [
    rofi # Spotlight
  ];

  home.file = {
    ".config/rofi/off.sh" = {
      source = ./off.sh;
      executable = true;
    };
    ".config/rofi/launcher.sh" = {
      source = ./launcher.sh;
      executable = true;
    };
    ".config/rofi/launcher_theme.rasi" = {
      source = ./launcher_theme.rasi;
    };
    ".config/rofi/powermenu.sh" = {
      source = ./powermenu.sh;
      executable = true;
    };
    ".config/rofi/powermenu_theme.rasi" = {
      source = ./powermenu_theme.rasi;
    };
  };
}
