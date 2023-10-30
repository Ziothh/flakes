{ inputs, lib, config, pkgs, outputs, user, ... }:
  # let 
  #   # pkgs = inputs.nixpkgs;
  # in
{
  # [Nix]
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # INFO: this is handled in home manager
    # Enable flakes
    # package = pkgs.nixFlakes;
    # extraOptions = "experimental-features = nix-command flakes";

    # gc = {
    #   enable = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 14d";
    # };

    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };


  # [System config]
  # Shell config
  programs.zsh.enable = true;
  environment = with pkgs; {
    shells = [ bash zsh ];
    # loginShell = [ zsh ];
    systemPackages = [ 
      coreutils # GNU core utilities
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      wget
    ];
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # [System settings]
  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # [Personisation]
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ 
      (nerdfonts.override { fonts = ["Meslo" "FiraCode" "FiraMono" ]; })
      # nerdfonts
      font-awesome
      google-fonts
      source-code-pro
      corefonts
    ];
  };
}
