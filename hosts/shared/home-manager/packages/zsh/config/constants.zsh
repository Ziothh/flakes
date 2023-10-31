# export DIGINAUT_DIR="/Users/digitalastronaut/Websites/websites"
# export WEBSITES_DIR="$HOME/Websites/websites"
# export WEBROOTS_DIR="$HOME/Websites/webroots"

# TODO: Maybe look into making these nix home.systemVariables

# [General config]
export TERMINAL="alacritty"
export EDITOR="nvim"
export VISUAL="nvim"
export CLICOLOR=1
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Set `bat` as the colorizing pager for man

# [Path]
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

# [Specifics]
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL="sparse"
