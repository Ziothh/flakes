{
  system = { pkgs, ... }: {
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
  };
}
