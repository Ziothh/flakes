{
  system = { ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    environment.variables.QT_QPA_PLATFORM = "wayland";
  };
  user = { pkgs, ... }: {
    home.packages = with pkgs; [
      pipewire     # video input source
      obs-studio   # screen recording
    ];
  };
}
