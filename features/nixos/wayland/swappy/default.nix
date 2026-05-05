{
  user = { pkgs, ... }: {
    home.packages = with pkgs; [ swappy ];
    home.file.".config/swappy/config".source = ./swappy.conf;
  };
}
