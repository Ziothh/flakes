{ inputs, outputs, user, ... }: 
  let
    pkgs = inputs.nixpkgs;
  in 
{
  imports = [
    ../shared/configuration.nix
  ];

  services.nix-daemon.enable = true;

  nixpkgs = {
    # # You can add overlays here
    # overlays = [
    #   # Add overlays your own flake exports (from overlays and pkgs dir):
    #   outputs.overlays.additions
    #   outputs.overlays.modifications
    #   # outputs.overlays.unstable-packages
    #
    #   # You can also add overlays exported from other flakes:
    #   # neovim-nightly-overlay.overlays.default
    #
    #   # Or define it inline, for example:
    #   # (final: prev: {
    #   #   hi = final.hello.overrideAttrs (oldAttrs: {
    #   #     patches = [ ./change-hello-to-hi.patch ];
    #   #   });
    #   # })
    # ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowInsecure = true;
      # PermittedInsecurePackages = [
      #   "python-2.7.18.6"
      # ];
    };
  };

  system.stateVersion = 4;

  system.defaults = {
    dock.autohide = true;

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 100; # Default 650ms
      KeyRepeat = 25;
    };
  };


  users.users."${user}" = {
    shell = inputs.nixpkgs.zsh;
  };


  # system.keyboard = {
  #   enableKeyMapping = true;
  #   remapCapsLockToEscape = true;
  # };
}
