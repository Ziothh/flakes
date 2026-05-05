# Features helper.
#
# A "feature" is a directory containing a single default.nix that returns an
# attrset:
#
#   {
#     features = [ <path> <path> ... ];   # optional: child features (recursive)
#     system   = { pkgs, ... }: { ... };  # optional: nix-darwin / NixOS module
#     user     = { pkgs, ... }: { ... };  # optional: home-manager user module
#   }
#
# A "host" is similarly shaped:
#
#   {
#     features = [ <path> ... ];          # opt-in feature list
#     module   = { ... }: { ... };        # host-specific module (hardware, hostName, ...)
#   }
#
# This file exports two layers:
#
#   collectFeatures :: [path] -> { systemModules; userModules; }
#     Walks the feature graph depth-first and gathers every `system` and
#     `user` block found, in declaration order. Pure, no side effects.
#
#   mkNixOSSystem  / mkDarwinSystem
#     Build a full nixosSystem / darwinSystem call from a host file +
#     surrounding environment (nixpkgs, user, etc.). flake.nix calls these.
#
# The mk* helpers automatically wire the HM<->system integration:
#   - home-manager.useUserPackages = true
#   - home-manager.extraSpecialArgs = specialArgs ++ { user; }
#   - home-manager.users.<user>.imports = collected user modules
# so individual hosts only declare their own bare config in `module`.

{ lib }:

let
  # Recursively walk feature directories, returning two flat module lists.
  collectFeatures = featurePaths:
    builtins.foldl'
      (acc: featPath:
        let
          m = import featPath;
          children = collectFeatures (m.features or [ ]);
        in {
          systemModules = acc.systemModules
            ++ children.systemModules
            ++ lib.optional (m ? system) m.system;
          userModules = acc.userModules
            ++ children.userModules
            ++ lib.optional (m ? user) m.user;
        })
      { systemModules = [ ]; userModules = [ ]; }
      featurePaths;

  # Assemble the module list passed to nixosSystem/darwinSystem.
  buildHostModules = { user, hostFile, hmExtraSpecialArgs }:
    let
      collected = collectFeatures hostFile.features;
    in
      [ hostFile.module ]
      ++ collected.systemModules
      ++ [
        ({ ... }: {
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = hmExtraSpecialArgs;
          home-manager.users.${user}.imports = collected.userModules;
        })
      ];
in {
  inherit collectFeatures buildHostModules;

  mkNixOSSystem =
    { user
    , hostFile
    , system
    , nixpkgs
    , specialArgs ? { }
    }:
    let
      sa = specialArgs // { inherit user; };
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = sa;
      modules =
        [ specialArgs.inputs.home-manager.nixosModules.home-manager ]
        ++ buildHostModules {
          inherit user hostFile;
          hmExtraSpecialArgs = sa;
        };
    };

  mkDarwinSystem =
    { user
    , hostFile
    , system
    , darwin
    , nixpkgs
    , specialArgs ? { }
    }:
    let
      sa = specialArgs // { inherit user; };
    in darwin.lib.darwinSystem {
      inherit system;
      specialArgs = sa;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      modules =
        [ specialArgs.inputs.home-manager.darwinModules.home-manager ]
        ++ buildHostModules {
          inherit user hostFile;
          hmExtraSpecialArgs = sa;
        };
    };
}
