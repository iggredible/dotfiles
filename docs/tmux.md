# Tmux
Clean up tmux files and directories:
```
rm -r ~/.tmux
rm ~/.tmux.conf
```

Create a `.tmux` directory:
```
mkdir -p ~/.tmux
```

Symlink the tmux files:
```
ln -sf ~/Projects/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Projects/dotfiles/.tmux ~/
```

Install [TPM](https://github.com/tmux-plugins/tpm)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Source TPM plugins:
```
Prefix + I
```

If you need to reload tmux:
```
Prefix + r
```
