# Funkey MacBook Air M2
{
  features = [ ../../features/macos ];

  module = { pkgs, lib, user, ... }: {
    system.stateVersion = 6;
    system.primaryUser = "${user}";

    system.defaults = {
      dock = {
        autohide = true;
        orientation = "right";
        magnification = false;

        tilesize = 52;

        mineffect = "scale"; # Faster minification animation

        show-recents = false;
        minimize-to-application = true;

        autohide-delay = 0.0;         # Eliminate delay before the Dock pops up
        autohide-time-modifier = 0.2; # Make the sliding animation blazingly fast (0.0 is instant snap)
      };

      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        FXPreferredViewStyle = "Nlsv"; # default to list view

        ShowPathbar = true;            # Show breadcrumbs at the bottom
        ShowStatusBar = true;          # Show disk space and item count
        QuitMenuItem = true;           # Allow quitting Finder via Cmd+Q
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark"; # dark mode

        # Finder
        AppleShowAllExtensions = true;

        # Keyboard
        KeyRepeat = 1; # fast key repeat
        InitialKeyRepeat = 10; # short delay before repeat kicks in
        ApplePressAndHoldEnabled = false; # repeat the key instead of showing the accent popup
        AppleKeyboardUIMode = 3; # Enable "Full Keyboard Access". Allows you to use the Tab key to navigate between buttons/inputs in standard macOS popups and alert dialogs

        # Auto correct
        NSAutomaticCapitalizationEnabled = false;     # Stop auto-capitalizing
        NSAutomaticDashSubstitutionEnabled = false;   # Stop converting -- into em-dashes
        NSAutomaticPeriodSubstitutionEnabled = false; # Stop adding periods with double space
        NSAutomaticQuoteSubstitutionEnabled = false;  # Stop using "smart" curly quotes (breaks code)
        NSAutomaticSpellingCorrectionEnabled = false; # Stop autocorrecting

        # Sounds
        "com.apple.sound.beep.volume" = 0.0; # Mute the system alert/error sound
        "com.apple.sound.beep.feedback" = 0; # Disable the "pop" feedback sound when changing the volume

        # Printing and saving
        NSNavPanelExpandedStateForSaveMode = true;  # Expand save panel by default
        NSNavPanelExpandedStateForSaveMode2 = true; # Backup flag for newer apps
        PMPrintingExpandedStateForPrint = true;     # Expand print panel by default
        PMPrintingExpandedStateForPrint2 = true;    # Backup print flag
      };

      trackpad = {
        Clicking = true;                # Enable tap-to-click
        TrackpadRightClick = true;      # Enable two-finger right click
        TrackpadThreeFingerDrag = true; # Move windows with three fingers (power user favorite)
      };

      loginwindow.GuestEnabled = false; # Drop guest user on lock screen

      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 1; # 0 = Never, 1 = Always, 2 = When space allows
      };

      screencapture.location = "~/Documents/screenshots";

      # CustomUserPreferences = {
      #   # Enable the Develop Menu and Web Inspector in Safari
      #   "com.apple.Safari" = {
      #     IncludeDevelopMenu = true;
      #     WebKitDeveloperExtrasEnabledPreferenceKey = true;
      #     "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
      #   };
      #
      #   # Required for modern macOS sandboxing to allow the menu to populate
      #   "com.apple.Safari.SandboxBroker" = {
      #     ShowDevelopMenu = true;
      #   };
      # };
    };

    security.pam.services.sudo_local.touchIdAuth = true; # This lets you use your fingerprint to authenticate `sudo` commands in the terminal!

    users.users."${user}".shell = pkgs.zsh;

    # Host-specific HM tweak
    home-manager.users."${user}".home.homeDirectory = lib.mkForce "/Users/${user}";
  };
}
