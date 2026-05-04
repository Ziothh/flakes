source ~/.config/flakes/scripts/prelude.zsh

# Update lockfile
echo "Updating flake lockfile..."
echo ""
nix flake update

source ~/.config/flakes/scripts/nixos/rebuild.zsh

echo ""
echo "Done!"
