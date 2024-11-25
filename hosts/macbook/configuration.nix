{ inputs, config, outputs, user, ... }: 
  let
    pkgs = inputs.nixpkgs;
  in 
{
  imports = [
    ../shared/configuration.nix
  ];

  services.nix-daemon.enable = true;

  system.stateVersion = 4;

  system.defaults = {
    dock.autohide = true;

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      # InitialKeyRepeat = 20; # Default 650ms
      # KeyRepeat = 5;
    };
  };

  # system.activationScripts.applications.text = pkgs.lib.mkForce (let 
  #   appDir = "~/Applications/Nix\ Apps";
  # in ''
  #   echo "Symlinking apps to ${appDir}"
  #   rm -rf ${appDir}
  #   mkdir -p ${appDir} || echo "ERROR: could not create folder to symlink apps"
  #   for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
  #     src="$(/usr/bin/stat -f%Y "$app")"
  #     echo "> Linking $app $src"
  #     cp -r "$src" ${appDir}
  #   done
  # '');

  users.users."${user}" = {
    shell = inputs.nixpkgs.zsh;
  };


  # system.keyboard = {
  #   enableKeyMapping = true;
  #   remapCapsLockToEscape = true;
  # };
}
