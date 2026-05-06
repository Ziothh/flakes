{
  user = { pkgs, ... }: {
    home.packages = with pkgs; [ wofi ];
    home.file.".config/wofi/config".source = ./config;
  };
}
