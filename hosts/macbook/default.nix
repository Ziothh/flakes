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
        FXPreferredViewStyle = "Nlsv"; # default to list view
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleInterfaceStyle = "Dark"; # dark mode
        KeyRepeat = 2; # fast key repeat
        InitialKeyRepeat = 15; # short delay before repeat kicks in
        ApplePressAndHoldEnabled = false; # repeat the key instead of showing the accent popup
      };
    };

    users.users."${user}".shell = pkgs.zsh;

    # Host-specific HM tweak
    home-manager.users."${user}".home.homeDirectory = lib.mkForce "/Users/${user}";
  };
}
