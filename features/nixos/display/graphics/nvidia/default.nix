{
  system = { user, ... }: {
    hardware.graphics.enable = true;   # was hardware.opengl.enable (renamed in newer nixpkgs)
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;                    # proprietary kernel module
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    users.users.${user}.extraGroups = [ "video" ];
  };
}
