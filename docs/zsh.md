# Zsh

Clean up `~/.zshrc` and `~/.zsh/`.
```
rm ~/.zshrc
rm -r ~/.zsh/
```

Create symlinks from your home directory to the files in this repository:

```bash
# Link .zshrc and .zsh/
ln -sf ~/Projects/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Projects/dotfiles/.zsh ~
```

Verify that the zsh files are symlinked:
```
ls -la ~/.zshrc
ls -la ~/Projects/dotfiles/.zsh
ls -la ~/.zsh/
```

Source the new configuration (you can also restart your terminal):
```bash
source ~/.zshrc
```


Note: Brewfile installs pure, to use it ([source](https://github.com/sindresorhus/pure?tab=readme-ov-file#getting-started)):

```
# .zshrc
autoload -U promptinit; promptinit
prompt pure
```
