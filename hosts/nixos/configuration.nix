# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let 
  userName="zioth";
in
{
  imports =
    [ 
    ];
  
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Get latest kernel
 
    # initrd.kernelModules = ["amdgpu"]; # TODO: check for NVidia instead of AMD

    # Bootloader.
    loader = {
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

  nix = {
    settings.auto-optimise-store = true;
   
    # INFO: this is handled in home manager
    # Enable flakes
    # package = pkgs.nixFlakes;
    # extraOptions = "experimental-features = nix-command flakes";

    # gc = {
    #   enable = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 14d";
    # };
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
    # Enable networking
    networkmanager.enable = true;


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

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

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
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

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
    openssh.enable = true;

    # Enable automatic login for the user.
    getty.autologinUser = "zioth";

  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    # PermittedInsecurePackages = [
    #   "python-2.7.18.6"
    # ];
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


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget

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

  # Shell config
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.variables = {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Personalisation
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerdfonts
      font-awesome
      google-fonts
      source-code-pro
      corefonts
    ];
  };

  security = {
    # Disable asking for sudo pwd whenever a `sudo` command is called
    sudo.wheelNeedsPassword = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userName} = {
    isNormalUser = true;
    description = "zioth";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "sound" "pulse" ];
    packages = with pkgs; [];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
