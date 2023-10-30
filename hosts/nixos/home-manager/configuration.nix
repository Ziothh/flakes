# Acts like a default.nix for system configurations for programs installed with Home Manager
{
  inputs,
  outputs,
  user,
  ...
}: {
  imports = [ 
    ./obs-studio/configuration.nix
    ./wayland/configuration.nix
  ];
}
