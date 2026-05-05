{
  features = [
    ./alacritty
    ./bat
    ./btop
    ./lf
    ./ranger
    ./starship
    ./zellij
    ./zsh
  ];

  system = { inputs, lib, config, pkgs, ... }: {
    # [Nix]
    nix = {
      # Add each flake input as a registry entry, so `nix3` commands resolve
      # the same way as the flake.
      registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
      # Mirror inputs into the legacy NIX_PATH for nix1/nix2 compat.
      nixPath = lib.mapAttrsToList
        (key: value: "${key}=${value.to.path}")
        config.nix.registry;
      settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
      };
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowInsecure = true;
    };

    environment.systemPackages = with pkgs; [
      coreutils
      neovim
      git
      wget
    ];

    time.timeZone = "Europe/Brussels";

    fonts.packages = with pkgs; [
      nerd-fonts.meslo-lg
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      font-awesome
      google-fonts
      source-code-pro
    ];
  };

  user = { pkgs, outputs, user, ... }: {
    home.packages = with pkgs; [
      # Base CLI
      htop          # resource monitor
      eza           # ls replacement
      xclip         # clipboard (pbcopy/pbpaste aliases)
      fzf
      skim          # selector
      ripgrep
      direnv        # directory-based environments
      gh            # GitHub CLI
      fastfetch     # cool graphic on terminal open

      # Editor
      neovim
        tree-sitter

      # Apps
      spotify
      vscode
      discord

      # Dev
      nodejs_24
      pnpm_10
      rustup
    ];

    nixpkgs = {
      overlays = [
        outputs.overlays.modifications
        # outputs.overlays.unstable-packages
      ];
      config = {
        allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
      };
    };

    programs.home-manager.enable = true;
    programs.git.enable = true;

    home.username = "${user}";
    # Don't change without reading the HM release notes:
    # https://nix-community.github.io/home-manager/release-notes.xhtml
    home.stateVersion = "23.05";
  };
}
