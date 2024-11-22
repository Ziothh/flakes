# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  user,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ../shared/configuration.nix

    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    ./home-manager/configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
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

  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Get latest kernel
 
    # initrd.kernelModules = ["amdgpu"]; # TODO: check for NVidia instead of AMD

    # Bootloader.
    loader = {
      # # TODO: This is just an example, be sure to use whatever bootloader you prefer
      # systemd-boot.enable = true;

      # Dualboot setup
      efi = {
        # canTouchEfiVariables = true;
        efiSysMountPoint  = "/boot/efi";
      };
      grub = {
        enable = true;
        # device = "/dev/sda";
        device = "nodev";
        # theme = pkgs.nixos.grub2-theme;
        useOSProber = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        configurationLimit = 100; # Limit stored configuration
        # configurationLimit = 5; # Limit stored configurations
      };
      timeout = 5; # Auto boot timeout
    };
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };


  networking = {
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
    # Enable networking
    networkmanager.enable = true;

    # Does not need to be enabled because I'm using networkmanager (CLI: `nm`, TUI: `nmtui`)
    # [Docs](https://nixos.org/manual/nixos/stable/#sec-wireless)
    # wireless = {
    #     enable = true;
    #     networks = {
    #         "Hogeweg 13 - verdiep 2" = {
    #             psk = "Heyvaerts25115!";
    #         };
    #     };
    # };


    # Disables the renaming of network devices (e.g. eth0 => ens3)
    # Currently disabled so that I can easilly reason about network devices by their name
    usePredictableInterfaceNames = false;


    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
  };

  # TTY layout
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    # useXkbConfig = true; # Use xkbOptions in tty 
  };


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # ! Temp disabled because I'm using pipewire
  # sound = {
  #   # enable = false; 
  #   enable = true;
  #   mediaKeys.enable = true;
  # };
  # hardware.pulseaudio = {
  #   enable = true;
  #   configFile = pkgs.writeText "default.pa" ''
  #     load-module module-bluetooth-policy
  #     load-module module-bluetooth-discover
  #     load-module module-bluez5-device
  #     load-module module-bluez5-discover
  #   '';
  # };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    # hsphfpd.enable = true; # HSP & HFP daemon
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;

  # List services that you want to enable:
  services = {
    # Configure keymap in X11
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      videoDrivers = ["nvidia"];

      autoRepeatDelay = 200;
      autoRepeatInterval = 50;

      # displayManager.sddm.enable = true;
      displayManager.gdm = {
        enable = true;
	      wayland = true;
      };

      # Disable going to sleep
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

      # desktopManager.plasma5.enable = true; # using wayland instead via hyprland
      # xkbOptions = {};
    };

    # Enable the OpenSSH daemon.
    # This setups a SSH server. Very important if you're setting up a headless system.
    # Feel free to remove if you don't need it.
    openssh = {
      enable = true;

      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # Use keys only. Remove if you want to SSH using password (not recommended)
        PasswordAuthentication = false;
      };
    };

    # Enable automatic login for the user.
    getty.autologinUser = "zioth";

    # User group for device management
    udev = {
      enable = true;
      extraRules = ''
      # Your rule goes here

      # [ Boards ]
      # # STM32F3DISCOVERY rev A/B - ST-LINK/V2
      # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", TAG+="uaccess"
      # # STM32F3DISCOVERY rev C+ - ST-LINK/V2-1
      # ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"
      # Raspberry Pi Debug Probe (CMSIS-DAP)
      ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", TAG+="uaccess"
      '';
    };
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Window manager
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;

    xwayland = {
      enable= true;
      # ! this might make the screen look pixelated
      # hidpi = true;
    };
  };


  environment.systemPackages = with pkgs; [
    # shit to get rust working
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
    # pkgs.openssl # E.g. used in prisma & some other rust packages
    perl
  ];

  security = {
    # Disable asking for sudo pwd whenever a `sudo` command is called
    sudo.wheelNeedsPassword = false;
  };

  fonts.packages = with pkgs; [
      corefonts
  ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.${user} = {
    # initialPassword = "correcthorsebatterystaple";
    isNormalUser = true;
    description = "zioth";
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    extraGroups = [ 
    # [ Linux ]
    "wheel" # Is sudo user
    "plugdev" # Non-sudo access to `/dev`
    "video" "audio" "sound" 
    # [ Applications ]
    "networkmanager" 
    "lp"
    # [ IDK ]
    "pulse" # pulseaudio
    ];
    packages = [];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05"; # Did you read the comment?
}
