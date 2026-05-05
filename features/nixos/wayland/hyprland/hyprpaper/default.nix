{
  user = { pkgs, ... }: {
    home.packages = with pkgs; [ hyprpaper ];
    home.file = {
      ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
      ".config/hypr/wallpapers".source     = ./wallpapers;
    };
  };
}
