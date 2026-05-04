# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    let
      # Pinned snapshot of nixpkgs from 2023-10-26 (same rev as the pre-upgrade
      # flake.lock). Used to keep specific tools at known-good versions during
      # the upgrade. Remove individual entries once each is verified against
      # current nixpkgs.
      pinned = import
        (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/63678e9f3d3afecfeafa0acead6239cdb447574c.tar.gz";
          sha256 = "sha256-gUihHt3yPD7bVqg+k/UVHgngyaJ3DMEBchbymBMvK1E=";
        })
        {
          inherit (prev.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        };
    in {
      neovim = pinned.neovim;            # 0.9.4 — current breaks plugin config
      tree-sitter = pinned.tree-sitter;  # 0.20.8 — pairs with pinned nvim
      direnv = pinned.direnv;            # 2.32.3 — current 2.37.1 checkPhase hangs
    };

  # # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };
}
