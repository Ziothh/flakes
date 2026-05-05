{
  user = { pkgs, ... }: {
    home.packages = with pkgs; [ tofi ];
    home.file = {
      ".config/tofi/tofi.conf".source          = ./tofi.conf;
      ".config/tofi/tofi.clip.conf".source     = ./tofi.clip.conf;
      ".config/tofi/tofi.launcher.conf".source = ./tofi.launcher.conf;
    };
  };
}
