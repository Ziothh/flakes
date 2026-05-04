# Resource monitor

{ ... }:
{
  programs.btop = {
    enable = true;
    extraConfig = builtins.readFile ./btop.conf;
  };

  # programs.btop has no `themes` option; link the custom theme manually.
  home.file.".config/btop/themes/proxzima.theme".source = ./themes/proxzima.theme;
}
