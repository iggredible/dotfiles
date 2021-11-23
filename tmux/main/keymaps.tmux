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
bind -r "<" swap-window -d -t -1
bind -r ">" swap-window -d -t +1

# join pane
bind-key j choose-window 'join-pane -h -s "%%"'
bind-key J choose-window 'join-pane    -s "%%"'

## Toggle between windows
bind-key Space last-window

## Toggle between sessions
bind-key C-Space switch-client -l

# Add binding to reload tmux.conf for fast, iterative development
bind r source-file ~/.tmux.conf \; display "~/.tmux.conf reloaded!"

# keep current path when creating new window
bind c new-window -c "#{pane_current_path}"

# go to a marked pane
bind \` switch-client -t'{marked}'

## Copy/paste
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
bind P paste-buffer

# Resizing pane
bind -r C-j resize-pane -D 15
bind -r C-k resize-pane -U 15
bind -r C-h resize-pane -L 15
bind -r C-l resize-pane -R 15

bind -n C-z run-shell "ps -o state= -o comm= -t '#{pane_tty}'"
