# Vim

Remove any existing vimrc (if any), then symlink the `.vim` directory to `dotfiles/vim/` directory:

```
rm -f ~/.vimrc
rm -rf ~/.vim
ln -sf ~/Projects/dotfiles/.vim ~/.vim
```

Note: When using `vim-devicons`, use `brew install font-hack-nerd-font --cask`, then in iTerm, open Preferences → Profiles → Text → Change Font → Select `Hack Nerd Font`.

## `lite` Mode

Some plugins are rarely used and can be omitted. In the terminal, run `VIM_MODE=lite vim`.

You can also add an alias in `.bashrc` / `.zshrc`:
```
alias vimlite='VIM_MODE=lite vim'
```

If you've already installed the non-lite plugins, you can uninstall them with `:PlugClean!`.