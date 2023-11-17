{ inputs, outputs, user, ... }: 
  let
    pkgs = inputs.nixpkgs;
  in 
{
  imports = [
    ../shared/configuration.nix
  ];

  services.nix-daemon.enable = true;

  system.stateVersion = 4;

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


  users.users."${user}" = {
    shell = inputs.nixpkgs.zsh;
  };


  # system.keyboard = {
  #   enableKeyMapping = true;
  #   remapCapsLockToEscape = true;
  # };
}
