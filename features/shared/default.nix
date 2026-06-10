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
    programs.git = {
      enable = true;
      userName = "Ziothh";
      userEmail = "louisgiet.w@gmail.com";
      signing.format = null;
      aliases.undo = "reset --soft HEAD^";
      # Syntax-highlighted, navigable diffs/pager. Reuses the bat theme
      # (see features/shared/bat). delta.enable wires core.pager automatically.
      delta = {
        enable = true;
        options = {
          navigate = true; # jump between files with n / N
          line-numbers = true;
          syntax-theme = "Catppuccin-mocha";
        };
      };
      extraConfig = {
        # Portable behavior (moved from ambient machine-local config)
        push.autoSetupRemote = true; # `git push` on a new branch sets upstream automatically
        push.default = "current"; # push the current branch to its same-named remote branch

        # Rebase hygiene — keep history linear, fewer accidental merge commits
        pull.rebase = true; # `git pull` rebases instead of merging
        rebase.autoStash = true; # auto stash/pop dirty changes around a rebase
        rebase.autoSquash = true; # honor fixup!/squash! commits without --autosquash
        fetch.prune = true; # drop local refs for branches deleted on the remote

        # Diffs & conflicts
        diff.algorithm = "histogram"; # smarter diffs than the default myers algorithm
        merge.conflictStyle = "zdiff3"; # conflict markers also show the common ancestor
        rerere.enabled = true; # remember conflict resolutions and replay them

        # Quality-of-life
        init.defaultBranch = "main"; # new repos start on `main`
        commit.verbose = true; # show the staged diff while writing the commit message
        branch.sort = "-committerdate"; # `git branch` lists most-recently-used first
        help.autocorrect = "prompt"; # on a typo'd command, prompt to run the intended one
      };
    };

    home.username = "${user}";
    # Don't change without reading the HM release notes:
    # https://nix-community.github.io/home-manager/release-notes.xhtml
    home.stateVersion = "23.05";
  };
}
