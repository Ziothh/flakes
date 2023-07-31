source ~/.config/flakes/scripts/prelude.zsh

# Update lockfile
echo "Updating flake lockfile..."
echo ""
nix flake update

source ~/.config/flakes/scripts/rebuild.zsh

echo ""
echo "Done!"
