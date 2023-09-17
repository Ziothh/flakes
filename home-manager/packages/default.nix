{ pkgs, ... }:
{
  imports = [
    # Terminal emulators
    ./alacritty
    ./kitty

    # TUIs
    ./bat
    ./btop
    ./lf
    ./ranger
    ./zellij

    # Terminal styling
    ./neofetch
    ./starship
  ];


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # [Terminal]
    ## Dependencies

    ## Base terminal CLI
    htop # resource monitor
    exa # ls replacement
    xclip # Clipboard management for my pbcopy and pbpaste aliasses 
    fzf
    skim # Select
    ripgrep 
    starship # Terminal prompt
    direnv # directory based environments

    ## Third party CLI
    gh

    ## Apps
    neovim 
      tree-sitter

    spotify
      spotify-tui

    # [Dev]
    nodejs_20
    # nodePackages_latest.pnpm

    rustup
      
    # [Apps]
    ## System functionality

    ## Development
    vscode

    ## Plebian
    firefox-devedition-unwrapped
    discord
    obsidian


    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
