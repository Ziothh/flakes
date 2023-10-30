{
  inputs,
  outputs,
  user,
  ...
}: {
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
}
