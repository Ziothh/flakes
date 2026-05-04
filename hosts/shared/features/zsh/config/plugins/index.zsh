# Auto completions
if [ -f ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh ]; then
  source ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
  export fpath=(~/.config/zsh/completions ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh $fpath)
else 
  echo "plugin: zsh-completions has not yet been fetched from github"
fi

# Auto suggestions
if [ -f ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else 
  echo "plugin: zsh-autosuggestions has not yet been fetched from github"
fi

# Syntax highlighting
if [ -f ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else 
  echo "plugin: zsh-syntax-highlighting has not yet been fetched from github"
fi
