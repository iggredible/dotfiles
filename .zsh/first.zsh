# zsh-autocomplete
source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# pure theme
autoload -U promptinit; promptinit
prompt pure # pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")


# Rbenv
FPATH=~/.rbenv/completions:"$FPATH"
autoload -U compinit; compinit
