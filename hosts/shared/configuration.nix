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

  nixpkgs = {
    # # You can add overlays here
    # overlays = [
    #   # Add overlays your own flake exports (from overlays and pkgs dir):
    #   outputs.overlays.additions
    #   outputs.overlays.modifications
    #   # outputs.overlays.unstable-packages
    #
    #   # You can also add overlays exported from other flakes:
    #   # neovim-nightly-overlay.overlays.default
    #
    #   # Or define it inline, for example:
    #   # (final: prev: {
    #   #   hi = final.hello.overrideAttrs (oldAttrs: {
    #   #     patches = [ ./change-hello-to-hi.patch ];
    #   #   });
    #   # })
    # ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowInsecure = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = _: true;
      # PermittedInsecurePackages = [
      #   "python-2.7.18.6"
      # ];
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
