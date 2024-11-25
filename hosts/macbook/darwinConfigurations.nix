# darwinConfigurations = { /* contents of this file */ }

{ inputs, outputs, user, ... }:
  let 
    darwin = inputs.darwin;
    home-manager = inputs.home-manager;
    pkgs = inputs.nixpkgs;
    lib = pkgs.lib;
  in 
{
  # Funkey Macbook Air M2
  "macbook" = let 
    system = "aarch64-darwin";
    # system = "x86_64-darwin"; # TODO: MAKE THIS A FOR LOOP
  in darwin.lib.darwinSystem {
    specialArgs = { inherit inputs outputs user lib; };

    inherit system;
    # system = "${system}";
    pkgs = import pkgs {
      inherit system;
      config.allowUnfree = true;
    };
    modules = [
      ./configuration.nix

      ./home-manager
    ];
  };
}
