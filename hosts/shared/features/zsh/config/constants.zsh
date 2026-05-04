# export DIGINAUT_DIR="/Users/digitalastronaut/Websites/websites"
# export WEBSITES_DIR="$HOME/Websites/websites"
# export WEBROOTS_DIR="$HOME/Websites/webroots"

# TODO: Maybe look into making these nix home.systemVariables

# [General config]
export TERMINAL="alacritty";
export TERM="alacritty";
export EDITOR="nvim";
export VISUAL="nvim";
export CLICOLOR=1;

# Set `bat` as the colorizing page for man
# [bat]
export MANPAGER="sh -c 'col -bx | bat -l man -p'";
export MANROFFOPT="-c"; # Fixes weird formatting for man with bat ('22m' characters being added where colors are set)
# [NVim]
# MANPAGER="nvim +Man\!"

# [Path]
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin";

# [Specifics]
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL="sparse";
