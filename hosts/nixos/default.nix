# Custom NixOS PC
{
  features = [ ../../features/nixos ];

  module = { inputs, lib, config, pkgs, user, ... }: {
    imports = [
      ./hardware.nix
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        efi.efiSysMountPoint = "/boot/efi";
        grub = {
          enable = true;
          device = "nodev";
          useOSProber = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          configurationLimit = 100;
        };
        timeout = 5;
      };
    };

    system.autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };

    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
      usePredictableInterfaceNames = false;
      firewall.enable = false;
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

    i18n.defaultLocale = "en_US.UTF-8";

    hardware = {
      bluetooth = {
        enable = true;
        settings.General.Enable = "Source,Sink,Media,Socket";
      };
      opengl.enable = true;
      nvidia.modesetting.enable = true;
    };
    services.blueman.enable = true;

    services = {
      xserver = {
        enable = true;
        layout = "us";
        xkbVariant = "";
        videoDrivers = [ "nvidia" ];
        autoRepeatDelay = 200;
        autoRepeatInterval = 50;
        displayManager.gdm = {
          enable = true;
          wayland = true;
        };
        serverFlagsSection = ''
          Option "BlankTime" "0"
          Option "StandByTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
        '';
        resolutions = [
          { x = 1920; y = 1080; }
          { x = 1600; y = 900; }
          { x = 3840; y = 2160; }
        ];
      };

      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
      };

      getty.autologinUser = "${user}";

      udev = {
        enable = true;
        extraRules = ''
          # Raspberry Pi Debug Probe (CMSIS-DAP)
          ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", TAG+="uaccess"
        '';
      };
    };

    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    environment.systemPackages = with pkgs; [
      # Stuff to get rust working
      glib
      glibc
      gcc
      pkg-config
      clang
      llvmPackages_16.bintools
      llvmPackages_16.stdenv
      libiconv
      openssl
      openssl.dev
      perl
    ];

    security.sudo.wheelNeedsPassword = false;

    fonts.packages = with pkgs; [ corefonts ];
    fonts.fontDir.enable = true;

    users.defaultUserShell = pkgs.zsh;
    users.users.${user} = {
      isNormalUser = true;
      description = "${user}";
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [
        "wheel" "plugdev" "video" "audio" "sound"
        "networkmanager" "lp" "pulse"
      ];
    };

    system.stateVersion = "23.05";

    # Host-specific HM tweak
    home-manager.users.${user}.home.homeDirectory = "/home/${user}";
  };
}
