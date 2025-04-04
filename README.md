# Dotfiles

## Tmux
TODO

## Vimrc

### Install

First, clone this repository. I like to keep it in `~/projects/`.

```
git clone https://github.com/iggredible/dotfiles.git
```

While automatic installation is WIP:
1. Install the dependencies (`git`, `fzf`, `ripgrep`, `node`)
2. Remove any existing vimrc and symlink a `.vim` directory to `dotfiles/vim/` directory

```
rm -r ~/.vimrc
rm -r ~/.vim
ln -s ~/projects/dotfiles/.vim ~/.vim
```
Note: when using `vim-devicons`, use `brew list font-hack-nerd-font`, then on iTerm, open Preferences -> Profiles -> Text -> Change Font -> Select `Hack Nerd Font`.

### Neovim

If using neovim, create `~/.config/init.vim`. Inside, add:
```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
```

### `lite` Mode

Some plugins are rarely used and can be omitted. On terminal, run `VIM_MODE=lite vim`.

You can also add an alias in `.bashrc` / `.zshrc`:
```
alias vimlite='VIM_MODE=lite vim'
```

If you've already installed the non-lite plugins, you can uninstall them with `:PlugClean!`.

# Tmux

```
rm .tmux.conf
ln -s ~/projects/dotfiles/.tmux.conf ~/.tmux.conf
```
