# runs rails console -- --nomultiline
# Other args will get passed to the `rails` command
rails() {
  if [ "$1" = "console" ] || [ "$1" = "c" ]; then
    shift
    bin/rails console -- --nomultiline "$@"
  else
    bin/rails "$@"
  fi
}

fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Create a directory and cd into it
mkd() {
	mkdir -p "$@" && cd "$_";
}

# with no arg: returns epoch
# with epoch arg: return date
epoch() {
 if [ $# -eq 0 ]; then
    date +%s
  else
    date -r "$@"
  fi
}

# get weather
wttr()
{
    local request="wttr.in/"
    [ "$(tput cols)" -lt 125 ] && request+='?n'
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

# extract different file extensions
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)  tar xjf "$1"    ;;
      *.tar.gz)   tar xzf "$1"    ;;
      *.tar)      tar xf "$1"     ;;
      *.tbz2)     tar xjf "$1"    ;;
      *.tgz)      tar xzf "$1"    ;;
      *.bz2)      bunzip2 "$1"    ;;
      *.gz)       gunzip "$1"     ;;
      *.zip)      unzip "$1"      ;;
      *.Z)        uncompress "$1" ;;
      *.7z)       7z x "$1"       ;;
      *)          echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Fuzzy search history with timestamps and execute selected command
# Uses fc instead of history
# Enhanced history command with fuzzy search if available
hist() {
  # Define timestamp format
  local format="%Y-%m-%d %H:%M:%S"

  # Check if fzf is available
  if command -v fzf >/dev/null 2>&1; then
    # Use fzf for interactive history search
    local cmd
    cmd=$(fc -lt "$format" 1 |
          fzf --tac --no-sort --exact +m --query="$*" |
          sed 's/^ *[0-9]*  \([0-9-]* [0-9:]*\) //') &&
    print -z "$cmd"
  else
    # Fallback to regular fc if fzf isn't available
    if [[ $# -eq 0 ]]; then
      fc -lt "$format" -20  # Show last 20 entries by default
    else
      fc -lt "$format" "$@"  # Pass any arguments to fc
    fi
  fi
}

tmux-switch() {
    if ! tmux info &> /dev/null; then
        echo "No tmux server running"
        return 1
    fi

    local session=$(tmux ls | \
        fzf --height=40% \
            --reverse \
            --preview 'tmux list-windows -t {1}' \
            --preview-window=right:50% | \
        cut -d: -f1)

    if [[ -n $session ]]; then
        tmux switch -t "$session"
    fi
}
