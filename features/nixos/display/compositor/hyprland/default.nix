{
  features = [
    ./grim
    ./hyprpaper
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
    home.file = {
      ".config/hypr/hyprland.conf".source = ./hyprland.conf;
      ".config/electron-flags.conf".source = ./electron-flags.conf;
    };
  };
}
