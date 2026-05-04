{ inputs, outputs, user, pkgs, ... }:
{
  imports = [
    # Per-feature HM modules
    ./features/alacritty/user.nix
    ./features/bat/user.nix
    ./features/btop/user.nix
    ./features/lf/user.nix
    ./features/ranger/user.nix
    ./features/starship/user.nix
    ./features/zellij/user.nix
    ./features/zsh/user.nix
  ];

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
}
