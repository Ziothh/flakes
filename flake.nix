{
  description = "zioth's nix config — features-graph architecture";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # macOS system configuration (like NixOS)
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      user = "zioth";
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Helper that walks the feature graph and assembles
      # nixosSystem / darwinSystem calls.
      features = import ./modules/features.nix { inherit (nixpkgs) lib; };
    in {
      # `nix fmt`
      formatter = forAllSystems
        (system: nixpkgs.legacyPackages.${system}.alejandra);

      # Overlays applied via shared/default.nix
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations.nixos = features.mkNixOSSystem {
        inherit user nixpkgs;
        system = "x86_64-linux";
        hostFile = import ./hosts/nixos;
        specialArgs = { inherit inputs outputs; };
      };

      darwinConfigurations.macbook = features.mkDarwinSystem {
        inherit user nixpkgs;
        inherit (inputs) darwin;
        system = "aarch64-darwin";
        hostFile = import ./hosts/macbook;
        specialArgs = { inherit inputs outputs; };
      };
    };
}
