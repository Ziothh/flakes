# darwinConfigurations = { /* contents of this file */ }

{ nixpkgs, darwin, home-manager, ... }:
{
  # Rosseel MacBook Pro 16
  "Louis-MacBook" = let 
    system = "x86_64-darwin";
    user = "zioth";
  in darwin.lib.darwinSystem {
    inherit system;
    # system = "${system}";
    pkgs = import nixpkgs {
      inherit system;
    };
    modules = [
      # ./darwin-config.nix

      home-manager.darwinModules.home-manager {
        nixpkgs = {
          config = { allowUnfree = true; };
        };

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users = {
            "${user}" = {
              home.homeDirectory = nixpkgs.lib.mkForce "/Users/${user}";
              imports = [
                ({ pkgs, ... }: {
                  home.stateVersion = "23.05";
                  # home.packages = with pkgs; [
                  #   # ripgrep
                  # ];

                  home.sessionVariables = {
                    EDITOR = "nvim";
                    CLICOLOR = 1;
                    # PAGER = "less"; # idk maybe use bat
                  };

                  programs.bat = {
                    enable = true;
                    config.theme = "TwoDark";
                  };

                  programs.fzf = {
                    enable = true;
                    enableZshIntegration = true;
                  };

                  programs.exa.enable = true;
                  programs.zsh = {
                    enable = true;
                    enableCompletion = true;
                    enableAutosuggestions = true;
                    enableSyntaxHighlighting = true;
                    shellAliases = {
                      ls = "ls --color=auto -F";
                    };
                  };
                })
              ];
            };
          };
        };
      }
    ];
  };
}
