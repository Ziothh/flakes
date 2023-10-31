# Acts like a default.nix for system configurations for programs installed with Home Manager
{
  inputs,
  outputs,
  user,
  pkgs,
  ...
}: 
  # let
  #   pkgs = inputs.nixpkgs;
  # in
{
  # Shell config
  programs.zsh.enable = true;
  environment = with pkgs; {
    shells = [ bash zsh ];
    # loginShell = [ zsh ];
    variables = {
    };
  };
}
