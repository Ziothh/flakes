echo "Asking for sudo access..."
sudo echo "Thanks!"

# echo "1. Building nix-darwin to ./result"
# nix build .#darwinConfigurations.Louis-MacBook.system --show-trace 

# echo "2. Using nix-darwin to rebuild the system with the flake"

# echo "2.1 Moving previous config files in `/etc` ..."
# sudo mv /etc/shells /etc/shells.before-nix-darwin || echo "Skipping moving of /etc/shells"
# sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin || echo "Skipping moving of /etc/bashrc"

# echo "2.2 Ruilding system"
./result/sw/bin/darwin-rebuild switch --flake ~/.config/nix-darwin --show-trace

