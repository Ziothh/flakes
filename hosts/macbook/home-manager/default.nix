# Home manager config for NixOS

{ inputs, user, pkgs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../shared/home-manager/homeConfiguration.nix
  ];

  home-manager.users."${user}" = {
    home.packages = with pkgs; [
      sequelpro
    ];

    home.sessionVariables = {
      # EDITOR = "nvim";
      CLICOLOR = 1;
      # PAGER = "less"; # idk maybe use bat
    };

    imports = [
      ../../shared/home-manager/user.nix
    ];

    # programs.bat = {
    #   enable = true;
    #   config.theme = "TwoDark";
    # };
    #
    # programs.fzf = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };
    #
    # programs.exa.enable = true;
    # programs.zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   enableAutosuggestions = true;
    #   enableSyntaxHighlighting = true;
    #   shellAliases = {
    #     ls = "ls --color=auto -F";
    #   };
    # };

    home.homeDirectory = pkgs.lib.mkForce "/Users/${user}";
  };
}
