# Dotfiles

## Zsh

### Install

#### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/Projects/dotfiles
```

### 2. Create the .zsh Directory in Your Home Directory (if it doesn't exist)

```bash
mkdir -p ~/.zsh
```

#### 3. Create Symlinks

You need to create symlinks from your home directory to the files in this repository:

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

#### 4. Restart Your Shell or Source the New Configuration

```bash
source ~/.zshrc
```

## MacOS

### Install

#### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/Projects/dotfiles
```

#### 2. Create a Symlink to the macOS Configuration File

```bash
ln -sf ~/Projects/dotfiles/.macos ~/.macos
```

#### 3. Make the Script Executable

```bash
chmod +x ~/.macos
```

#### 4. Run the Script

```bash
~/.macos
```

**Note**: The script will ask for administrator privileges since some settings require `sudo` access. You'll be prompted for your password.

## Tmux

TODO

## Vimrc

TODO

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
