source ~/.config/flakes/scripts/prelude.zsh

# Build nixos
echo "Switching nixos to use the latest config..."
echo ""
sudo nixos-rebuild switch --impure --flake .# --show-trace 
# .#<host> defaults to current host
# --impure allows abosolute paths

# Build home manager
# old:
# nix build .#hmConfig.zioth.activationPackage --impure
# now done with nixos rebuild in config
