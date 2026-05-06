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
  };
}
