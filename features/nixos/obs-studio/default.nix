{
  features = [ ../audio ];   # OBS uses the system audio stack (pipewire)
  user = { pkgs, ... }: {
    home.packages = with pkgs; [ obs-studio ];
  };
}
