FPATH=~/.rbenv/completions:"$FPATH"
autoload -U compinit; compinit
eval "$(rbenv init - zsh)"
export PATH="$HOME/.rbenv/bin:$PATH"
