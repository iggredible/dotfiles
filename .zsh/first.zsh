if type brew &>/dev/null; then
  # zsh-completions
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit; compinit
  autoload -U promptinit; promptinit
  prompt pure # pure
fi
