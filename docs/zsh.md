# Zsh

❗️Ensure that dependencies are installed
```
brew bundle
```

Clean up `~/.zshrc` and `~/.zsh/`.
```
rm ~/.zshrc
rm -r ~/.zsh/`
```

Create the .zsh Directory in home directory:
```bash
mkdir -p ~/.zsh
```

Create symlinks from your home directory to the files in this repository:

```bash
# Link .zshrc and .zsh/
ln -sf ~/Projects/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Projects/dotfiles/.zsh .
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
