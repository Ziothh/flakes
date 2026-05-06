{
  user = { pkgs, ... }: {
    home.packages = with pkgs; [ wlogout ];
    home.file = {
      ".config/wlogout/actions".source   = ./actions;
      ".config/wlogout/layout".source    = ./layout;
      ".config/wlogout/launch.sh"        = { source = ./launch.sh; executable = true; };
      ".config/wlogout/style.css".source = ./style.css;
      ".config/wlogout/icons".source     = ./icons;
    };
  };
}
