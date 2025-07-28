# Neovim

If using Neovim, create `~/.config/nvim/init.vim`. Inside, add:
```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
```
