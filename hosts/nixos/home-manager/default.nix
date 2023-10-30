# Home manager config for NixOS

{ inputs, outputs, user, ... }:
let 
  pkgs = inputs.nixpkgs;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../shared/home-manager/homeConfiguration.nix
  ];

  home-manager.users.${user} = {
    home.packages = with pkgs; [ 
      firefox-devedition-unwrapped
    ];

    imports = [ 
      ../../shared/home-manager/user.nix

      ./obs-studio
      ./wayland
    ];

    home.homeDirectory = "/home/${user}";

    # imports = [ 
    #   (../../home-manager/home.nix)
    # ] ++ [
    #   (./home)
    # ];
  };
}
