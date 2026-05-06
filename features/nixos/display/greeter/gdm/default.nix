{
  features = [ ../../protocol/xserver ];   # GDM lives under services.xserver in NixOS

  system = { ... }: {
    services.displayManager.gdm = {        # was services.xserver.displayManager.gdm.* (renamed)
      enable = true;
      wayland = true;
    };
  };
}
