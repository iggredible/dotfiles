# Load ~/.zshrc
for file in ~/.zsh/{first,aliases,etc,exports,funcs}.zsh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
