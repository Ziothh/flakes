# cat replacement

{ pkgs, ... }:
{
  home.packages = with pkgs; [ alacritty ];

  home.file = {
    ".config/alacritty/alacritty.yml" = if pkgs.stdenv.isDarwin then {
      text = builtins.readFile ./alacritty.yml + builtins.readFile ./alacritty.darwin.yml;
    } else {
      source = ../alacritty/alacritty.yml;
    };
  };
}
