# Shell config
# TODO: auto fetch `plugins` folder content from github

{ pkgs, ... }:
{
  home.packages = with pkgs; [
  ];

  home.file = {
    ".zshrc" = {
      source = ./.zshrc;
      recursive = false;
    };
    ".zshenv" = {
      source = ./.zshenv;
      recursive = false;
    };
    ".config/zsh" = {
      source = ../zsh;
      recursive = true;
    };
  };
}
