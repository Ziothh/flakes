# nixosConfigurations = { /* contents of this file */ }

{ inputs, outputs, user, ... }:
let 
  nixpkgs = inputs.nixpkgs;
  home-manager = inputs.home-manager;
  lib = nixpkgs.lib;
in
{      
  # # FIXME replace with your hostname
  # your-hostname = nixpkgs.lib.nixosSystem {
  #   specialArgs = {inherit inputs outputs;};
  #   modules = [
  #     # > Our main nixos configuration file <
  #     ./nixos/configuration.nix
  #   ];
  # };

  # Hostname
  nixos = lib.nixosSystem {
    # system = "x86_64-linux";
    specialArgs = { inherit inputs outputs user; };
    modules = [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # NixOS configuration
      ./configuration.nix 
      # Home Manager configuration
      ./home-manager
    ];
  };
}
