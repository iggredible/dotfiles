# Dotfiles

## Installs

Clone the repo. Let's say you want to store it in a directory called `~/Projects`.

```bash
git clone https://github.com/iggredible/dotfiles.git ~/Projects/dotfiles
```

### Git

```
ln -sf ~/Projects/dotfiles/.gitconfig ~/.gitconfig
```

### Zsh

#### Create the .zsh Directory in Your Home Directory (if it doesn't exist)

```bash
mkdir -p ~/.zsh
```

#### Create Symlinks

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

#### Restart Your Shell or Source the New Configuration

```bash
source ~/.zshrc
```

### MacOS


#### Create a Symlink to the macOS Configuration File

```bash
ln -sf ~/Projects/dotfiles/.macos ~/.macos
```

#### Make the Script Executable

```bash
chmod +x ~/.macos
```

#### Run the Script

```bash
~/.macos
```

**Note**: The script will ask for administrator privileges since some settings require `sudo` access. You'll be prompted for your password.

### Tmux

Create a symlink to tmux conf:

```
ln -s ~/projects/dotfiles/.tmux.conf ~/.tmux.conf
```

### Vimrc

Remove any existing vimrc (if any), then symlink the `.vim` directory to `dotfiles/vim/` directory:

```
rm -r ~/.vimrc
rm -r ~/.vim
ln -s ~/projects/dotfiles/.vim ~/.vim
```

Note: when using `vim-devicons`, use `brew install font-hack-nerd-font --cask`, then on iTerm, open Preferences -> Profiles -> Text -> Change Font -> Select `Hack Nerd Font`.

#### `lite` Mode

Some plugins are rarely used and can be omitted. On terminal, run `VIM_MODE=lite vim`.

You can also add an alias in `.bashrc` / `.zshrc`:
```
alias vimlite='VIM_MODE=lite vim'
```

If you've already installed the non-lite plugins, you can uninstall them with `:PlugClean!`.

#### Neovim

If using neovim, create `~/.config/init.vim`. Inside, add:
```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
```

