# Config shortcuts
# alias zshconfig="code ~/.zshrc"
# alias aliasconfig="code ~/.console/alias.sh"

# Basic aliasses
alias c="clear && printf '\e[3J'"
alias src="c && source ~/.zshrc && echo 'Reloaded ~/.zshrc'"

function mkcd {
  mkdir -p $1
  cd $1
}
alias trim="awk '{\$1=\$1;print}'"
alias ip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127. 0.0.1' | sk | trim | pbcopy"

alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

# Open certain config directories in your editor of choice
# function config {
#   key="$1"
#   dir=""
#   prev="$PWD"

#   if [[ "$key" == "zsh" ]]; then
#     dir="~/.config/zsh/"
#   elif [[ "$key" == "nvim" ]]; then
#     dir="~/.config/nvim/"
#   fi

#   if [[ "$dir" == "" ]]; then
#     echo "Invalid option \"$key\". Possible options are: zsh, nvim"
#   else
#     cd "$dir"
#     "${EDITOR:-vi}" .
#     cd "$prev"
#   fi
# }

# Terminal apps
alias z=zellij

# NeoVim
# alias vim="nvim"
alias v="$EDITOR ."

# Node
NODE_PACKAGE_MANAGER='pnpm'
alias nrd="$NODE_PACKAGE_MANAGER dev"
alias nrw="$NODE_PACKAGE_MANAGER watch"
alias nrh="$NODE_PACKAGE_MANAGER host"
alias nrb="$NODE_PACKAGE_MANAGER build"
alias nrb:w="$NODE_PACKAGE_MANAGER build --watch"

# Python
alias pyenv="source env/bin/activate"
