# Load zsh files

# Load first.zsh first
[ -f ~/.zsh/first.zsh ] && source ~/.zsh/first.zsh

# Enable nullglob so the glob returns nothing instead of erroring if no matches
setopt nullglob

# load everything else except `first.zsh` and `last.zsh`
for file in ~/.zsh/*.zsh; do
    [[ "$(basename "$file")" == "first.zsh" ]] && continue
    [[ "$(basename "$file")" == "last.zsh" ]] && continue
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Reset to default behavior
unsetopt nullglob

# Load last.zsh last
[ -f ~/.zsh/last.zsh ] && source ~/.zsh/last.zsh
