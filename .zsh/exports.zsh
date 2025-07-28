# Vim default
export EDITOR='vim';

# Prefers fc over history command
# These history configs will work with fc
# Increase Zsh history size. Allow 32^3 entries.
export HISTSIZE=32768

# Increase persisted history size
export SAVEHIST=$HISTSIZE

# ignore duplicates and space
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# When the history file reaches its maximum size (SAVEHIST), this option tells Zsh to remove duplicate entries first before removing unique commands
setopt HIST_EXPIRE_DUPS_FIRST

# When navigating through history (with up/down arrows or history search), if the same command appears multiple times, you'll only see it once
setopt HIST_FIND_NO_DUPS

# Share history between multiple Zsh sessions
setopt SHARE_HISTORY

# Add timestamps to history
setopt EXTENDED_HISTORY

# Colorize grep matches
export GREP_OPTIONS="--color=auto"

# # Nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Homebrew
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/highlighters

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5f87d7"

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)
