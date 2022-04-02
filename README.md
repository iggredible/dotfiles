# Dotfiles

## Installation

Please run:

```
sh -c "`curl -fsSL https://raw.githubusercontent.com/iggredible/dotfiles/master/install.sh`"
```

**WIP, stay tuned! :)**

## Symlink

```
rm ~/.vimrc
ln -s ~/path/to/dotfiles/vim/ ~/.vim
```

## Neovim

If using neovim, create `~/.config/init.vim`. Inside, add:
```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
```
