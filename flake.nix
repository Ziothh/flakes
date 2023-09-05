{
  description = "A very basic flake";

  inputs = {
    # Required to let nix know where to fetch packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
       url = github:nix-community/home-manager;
       inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      # For MacOS
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # nixConfg = {};

  outputs = inputs @ { self, nixpkgs, darwin, home-manager, ... }:
    let
      user = "zioth";
      lib = nixpkgs.lib;

      forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "x86_64-darwin"];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
      homeManagerConfFor = config:
        { ... }: {
          nixpkgs.overlays = [
            # nur.overlay
            # syncorate-el.overlays.emacs
            # (swarm-overlay swarm)
            # (combobulate-overlay combobulate.outPath)
            # sebastiant-emacs-overlay
            # git-mob.overlays.default
          ];
          imports = [ config ];
        };


      pkgs = forEachSystem (system: 
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
      # debianSystem = home-manager.lib.homeManagerConfiguration {
      #   configuration = homeManagerConfFor ./hosts/t14-debian/home.nix;
      #   system = "x86_64-linux";
      #   homeDirectory = "/home/sebastian";
      #   username = "sebastian";
      #   stateVersion = "21.05";
      # };
    in {
      # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      # darwinConfigurations = {
      #   hostname = darwin.lib.darwinSystem {
      #     system = "x86_64-darwin";
      #     modules = [
      #       ./configuration.nix
      #       home-manager.darwinModules.home-manager
      #       {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.users.jdoe = import ./home.nix;
      #
      #         # Optionally, use home-manager.extraSpecialArgs to pass
      #         # arguments to home.nix
      #       }
      #     ];
      #   };
      # };



      # nixosConfigurations = (
      #   import ./hosts {
      #     system = "x86_64-linux";
      #     inherit nixpkgs self inputs user home-manager;
      #     inherit (nixpkgs) lib;
      #   }
      # );

      nixosConfigurations = {
        # nixos is the username
        nixos = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            # Include the results of the hardware scan.
            ./hosts/nixos/hardware-configuration.nix
            # NixOS configuration
            ./hosts/nixos/configuration.nix 

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit user; };
              home-manager.users.${user} = {
                imports = [ 
                  (./home-manager/home.nix)
                ] ++ [
                  (./hosts/nixos/home)
                ];
                # imports = [ 
                #   (/home/${user}/.config/home-manager/home.nix)
                # ] ++ [
                #   (./home)
                # ];
              };
            }
          ];
        };
      };
      # debian = debianSystem.activationPackage;
      # defaultPackage.x86_64-linux = debianSystem.activationPackage;
      # packages.x86_64-darwin.default = darwinSystem.system;
      darwinConfigurations = {
        "Louis-MacBook" = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./hosts/macbook/darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.users.${user} = {
                imports = [ 
                  (./home-manager/home.nix)
                ] ++ [
                  (./hosts/macbook/home)
                ];
              };
                # homeManagerConfFor ./hosts/macbook/home.nix;
            }
          ];
          specialArgs = { 
            inherit inputs; 
            inherit pkgs; 
            inherit nixpkgs; 
            inherit user; 
          };
        };
      };
  };
}
