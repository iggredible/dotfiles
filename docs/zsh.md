# Zsh

Create the .zsh Directory in Your Home Directory (if it doesn't exist)

```bash
mkdir -p ~/.zsh
```

Create symlinks from your home directory to the files in this repository:

```bash
# Link .zshrc
ln -sf ~/Projects/dotfiles/.zshrc ~/.zshrc

# Link all .zsh files
ln -sf ~/Projects/dotfiles/.zsh/first.zsh ~/.zsh/first.zsh
ln -sf ~/Projects/dotfiles/.zsh/aliases.zsh ~/.zsh/aliases.zsh
ln -sf ~/Projects/dotfiles/.zsh/etc.zsh ~/.zsh/etc.zsh
ln -sf ~/Projects/dotfiles/.zsh/exports.zsh ~/.zsh/exports.zsh
ln -sf ~/Projects/dotfiles/.zsh/funcs.zsh ~/.zsh/funcs.zsh
```

Restart Your Shell or Source the New Configuration

```bash
source ~/.zshrc
```