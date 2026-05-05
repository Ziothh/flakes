# Custom NixOS PC
{
  features = [ ../../features/nixos ];

  module = { user, ... }: {
    imports = [ ./hardware.nix ];

    # ── Host-specific bits only. Anything reusable lives in features/. ──

    networking.hostName = "nixos";

    # Host-specific dev hardware: Raspberry Pi Debug Probe (CMSIS-DAP)
    services.udev = {
      enable = true;
      extraRules = ''
        ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", TAG+="uaccess"
      '';
    };

    system.stateVersion = "23.05";

    # Host-specific HM tweak (path differs between hosts: /home vs /Users)
    home-manager.users.${user}.home.homeDirectory = "/home/${user}";

    # ── Graphics + display still inline (extracted in next commit) ──

    hardware = {
      opengl.enable = true;
      nvidia = {
        modesetting.enable = true;
        open = false;   # proprietary kernel module
      };
    };

    services.xserver = {
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

    # Video group for graphics access (will move to graphics/nvidia in next commit)
    users.users.${user}.extraGroups = [ "video" ];
  };
}
