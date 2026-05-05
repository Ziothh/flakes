{
  features = [ ./hyprpaper ];
  user = { ... }: {
    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
