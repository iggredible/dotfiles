# Tmux plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'dracula/tmux'

# Dracula customization https://draculatheme.com/tmux
set -g @dracula-plugins "battery cpu-usage time"
set -g @dracula-battery-colors "dark_purple yellow"
set -g @dracula-border-contrast true
set -g @dracula-show-powerline true
set -g @dracula-show-left-icon session
set -g @dracula-cpu-usage-label "■"
