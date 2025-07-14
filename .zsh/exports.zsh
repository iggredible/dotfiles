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

# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Homebrew
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# Searchkick
export SEARCHKICK_ENV=''
export OPENSEARCH_URL=http://127.0.0.1:9200

# GoLang
# add go https://stackoverflow.com/questions/34708207/command-not-found-go-on-mac-after-installing-go
export PATH=$PATH:/usr/local/go/bin

# localhost crashing fix
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
