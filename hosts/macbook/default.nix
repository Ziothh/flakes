# Funkey MacBook Air M2
{
  features = [ ../../features/macos ];

  module = { pkgs, lib, user, ... }: {
    system.stateVersion = 4;
    system.primaryUser = "${user}";

    system.defaults = {
      dock.autohide = true;

      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };

      NSGlobalDomain.AppleShowAllExtensions = true;
    };

    users.users."${user}".shell = pkgs.zsh;

    # Host-specific HM tweak
    home-manager.users."${user}".home.homeDirectory = lib.mkForce "/Users/${user}";
  };
}
