{
  description = "A very basic flake";

  inputs = {
    # Required to let nix know where to fetch packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
       url = github:nix-community/home-manager;
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # nixConfg = {};

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      user= "zioth";
    in {
      # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;



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
          inherit system;
          modules = [ 
            # NixOS configuration
            ./configuration.nix 

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit user; };
              home-manager.users.${user} = {
                imports = [ 
                  (/home/${user}/.config/home-manager/home.nix)
                ] ++ [
                  (./home)
                ];
              };
            }
          ];
        };
      };
  };
}
