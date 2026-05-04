# Cool prompt on terminal open

{ ... }:
{
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
