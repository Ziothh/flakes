{ inputs, outputs, user, ...}: 
{
  # home-manager.useGlobalPkgs = true; # nixpkgs options are diabled when useGlobalPkgs is enabled
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs outputs user; };


  nixpkgs = {
    config = { 
      allowUnfree = true; 
    };
  };
}
