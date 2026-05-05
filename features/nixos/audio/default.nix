{
  system = { user, ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    users.users.${user}.extraGroups = [ "audio" "pulse" "sound" ];
  };
}
