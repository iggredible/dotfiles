# Vim

Remove any existing vimrc (if any), then symlink the `.vim` directory to `dotfiles/vim/` directory:

```
rm -f ~/.vimrc
rm -rf ~/.vim
ln -sf ~/Projects/dotfiles/.vim ~/.vim
```

Notes:
- When using `vim-devicons`, use `brew install font-hack-nerd-font --cask`, then in iTerm, open Preferences → Profiles → Text → Change Font → Select `Hack Nerd Font`.
- You have to install [vim-plug](https://github.com/junegunn/vim-plug#installation) too.
