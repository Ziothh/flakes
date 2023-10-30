# darwinConfigurations = { /* contents of this file */ }

{ inputs, outputs, user, ... }:
  let 
    darwin = inputs.darwin;
    home-manager = inputs.home-manager;
    pkgs = inputs.nixpkgs;
    lib = pkgs.lib;
  in 
{
  # Rosseel MacBook Pro 16
  "Louis-MacBook" = let 
    system = "x86_64-darwin";
  in darwin.lib.darwinSystem {
    specialArgs = { inherit inputs outputs user lib; };

    inherit system;
    # system = "${system}";
    pkgs = import pkgs {
      inherit system;
    };
    modules = [
      ./configuration.nix

      ./home-manager
    ];
  };
}
