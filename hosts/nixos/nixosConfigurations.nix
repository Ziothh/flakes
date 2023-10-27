# nixosConfigurations = { /* contents of this file */ }

{ lib, nixpkgs, home-manager, user, ... }:
{        # nixos is the username
  nixos = lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # NixOS configuration
      ./configuration.nix 

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ 
            (../../home-manager/home.nix)
          ] ++ [
            (./home)
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
}
