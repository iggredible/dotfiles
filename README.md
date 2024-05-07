# Dotfiles

## Vimrc

First,lone this repository. I like to keep it in `~/projects/`.

```
git clone https://github.com/iggredible/dotfiles.git
```

### Symlink

While automatic installation is WIP:
1. Install the dependencies (`git`, `fzf`, `ripgrep`, `node`)
2. Remove any existing vimrc and symlink a `.vim` directory to `dotfiles/vim/` directory

```
rm -r ~/.vimrc
rm -r ~/.vim
ln -s ~/projects/dotfiles/vim ~/.vim
```

### Neovim

If using neovim, create `~/.config/init.vim`. Inside, add:
```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
```
