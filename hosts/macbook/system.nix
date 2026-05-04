{ inputs, config, outputs, user, pkgs, ... }:
{
  imports = [
    ../shared/system.nix
    inputs.home-manager.darwinModules.home-manager
  ];

  system.stateVersion = 4;
  system.primaryUser = "${user}";

  system.defaults = {
    dock.autohide = true;

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      # InitialKeyRepeat = 20; # Default 650ms
      # KeyRepeat = 5;
    };
  };

  users.users."${user}".shell = pkgs.zsh;

  # Home Manager <-> nix-darwin integration
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs outputs user; };
  home-manager.users."${user}" = {
    imports = [ ../shared/home.nix ];
    home.homeDirectory = pkgs.lib.mkForce "/Users/${user}";
  };
}
