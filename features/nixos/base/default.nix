# Foundational system settings: locale, fonts, sudo, autologin, user account.
# Distributed extraGroups: features that need specific group membership add
# their own. base only adds [wheel plugdev lp] — generic desktop access.
{
  system = { pkgs, user, ... }: {
    # Locale
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
    i18n.defaultLocale = "en_US.UTF-8";

    # NixOS-specific system fonts (in addition to features/shared/default.nix)
    fonts.packages = with pkgs; [ corefonts ];
    fonts.fontDir.enable = true;

    # Passwordless sudo for the wheel group
    security.sudo.wheelNeedsPassword = false;

    # Auto-login on TTY1
    services.getty.autologinUser = "${user}";

    # Default shell
    users.defaultUserShell = pkgs.zsh;

    # User account creation. Group membership distributed across features.
    users.users.${user} = {
      isNormalUser = true;
      description = "${user}";
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [
        "wheel"      # sudo
        "plugdev"    # USB / hot-plug devices
        "lp"         # printers
      ];
    };
  };
}
