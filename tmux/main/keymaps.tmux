# Bind Prefix to C-Space
unbind C-Space
set -g prefix C-Space
bind C-Space send-prefix

# more intuitive splits
bind-key "|" split-window -h -c "#{pane_current_path}"
bind-key "\\" split-window -fh -c "#{pane_current_path}"

bind-key "-" split-window -v -c "#{pane_current_path}"
bind-key "_" split-window -fv -c "#{pane_current_path}"

# swap windows
bind-key -r "<" swap-window -d -t -1
bind-key -r ">" swap-window -d -t +1

## Toggle between windows
bind-key Space last-window

## Toggle between sessions
bind-key C-Space switch-client -l

# Add binding to reload tmux.conf for fast, iterative development
bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded!"

# keep current path when creating new window
bind c new-window -c "#{pane_current_path}"

# Vi mode
setw    -g  mode-keys    vi

## Copy/paste
bind-key -T copy-mode-vi v                 send      -X begin-selection
bind-key -T copy-mode-vi y                 send-keys -X copy-pipe-and-cancel "pbcopy"
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
bind-key -T copy-mode-vi P                 send-keys -X copy-selection
bind-key -T copy-mode-vi ]                 send-keys -X copy-selection

# Resizing pane
bind -r C-j resize-pane -D 15
bind -r C-k resize-pane -U 15
bind -r C-h resize-pane -L 15
bind -r C-l resize-pane -R 15

