{
  features = [
    ./grim
    ./hyprland
    ./rofi
    ./swappy
    ./swaync
    ./tofi
    ./waybar
    ./wlogout
    ./wofi
  ];

  system = { ... }: {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  user = { ... }: {
    home.file.".config/electron-flags.conf".source = ./electron-flags.conf;
  };
}
