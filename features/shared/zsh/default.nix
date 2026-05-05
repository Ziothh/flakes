{
  system = { pkgs, ... }: {
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ bash zsh ];
  };
  user = { ... }: {
    home.file = {
      ".zshrc".source       = ./.zshrc;
      ".zshenv".source      = ./.zshenv;
      ".config/zsh".source  = ./config;
    };
  };
}
