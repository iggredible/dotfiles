# Renumber windows sequentially after closing any of them.
# Otherwise if you close the second tab of three, you end up with tabs numbered 1 and 3
set -g renumber-windows on

# scroll, clickable windows and panes, resizable panes
set -g mouse on

# Default was 2000 lines
set -g history-limit 5000

# Prevent auto-renaming windows
set -g allow-rename off

# set window and pane index to 1 (default was 0)
set -g base-index 1
setw -g pane-base-index 1

# tmux messages are displayed for 4 seconds
set -g display-time 4000

# set the default-terminal to use screen-256color
set -g default-terminal "screen-256color"

# Vi mode
setw -g mode-keys vi
