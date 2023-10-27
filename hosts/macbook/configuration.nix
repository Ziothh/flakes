{ pkgs, ... }: {
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
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };


  programs.zsh.enable = true;
  environment = with pkgs; {
    shells = [ bash zsh ];
    loginShell = [ zsh ];
    systemPackages = [ coreutils ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';


  # system.keyboard = {
  #   enableKeyMapping = true;
  #   remapCapsLockToEscape = true;
  # };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ 
      (nerdfonts.override { fonts = ["Meslo" "FiraCode" "FiraMono" ]; })
    ];
  };
}
