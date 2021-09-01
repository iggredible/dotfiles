#!/usr/bin/env bash

packages=("fzf" "universal-ctags" "ripgrep")

if [ "$(uname)" == "Darwin" ]; then
    for package in "${packages[@]}"
    do
        if brew list $package &>/dev/null; then
            echo "$(tput setaf 2) $package is already $(tput setaf 3)installed$(tput sgr0)"
        else
            brew install $package && echo "$(tput setaf 2)$package is $(tput setaf 3)installed$(tput sgr0)"
        fi

    done
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt update
    for package in "${packages[@]}"
    do
        dpkg -s $package &> /dev/null
        if [ $? -ne 0 ]; then
            sudo apt install $package  && echo "$(tput setaf 2)$package is $(tput setaf 3)installed$(tput sgr0)"
        else
            echo "$(tput setaf 2)$package is already $(tput setaf 3)installed$(tput sgr0)"
        fi
    done

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # TODO
    echo "Hello Windows <32 bit"

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # TODO
    echo "Hello Windows 64 bit"

fi

echo "$(tput setaf 4)Dependency check done. All dependencies have been $(tput setaf 3)installed$(tput sgr0)"

echo "$(tput setaf 5)Removing the current ~/.vim and ~/.vimrc$(tput sgr0)"
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1

echo "$(tput setaf 6)Symlinking vim/ and vimrc$(tput sgr0)"
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/vim ~/.vim

echo "$(tput setaf 3)$(tput bold)You're all set!$(tput sgr0)"

# WIP
# Creating an install scipt
# First, gain admin control
# sudo chown -R $(whoami):admin /usr/local

# instll xcode-select
# xcode-select — install

# install, diagnose, and update homebrew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# brew doctor
# brew update

# this adds /usr/local/bin to $PATH
# echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.zshrc
# source ~/.zshrc

#=====
# error removals
#=====
# removing the old dotfiles
# 2 is stderr and 1 is stdout
# probably shouldve been written rm -rf whatever 1> /dev/null 2>&1
# sudo rm -rf ~/.vim > /dev/null 2>&1
# sudo rm -rf ~/.vimrc > /dev/null 2>&1
# sudo rm -rf ~/.zshrc > /dev/null 2>&1
# sudo rm -rf ~/.tmux > /dev/null 2>&1
# sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
# sudo rm -rf ~/.zsh_prompt > /dev/null 2>&1
# sudo rm -rf ~/.zshrc > /dev/null 2>&1
# sudo rm -rf ~/.gitconfig > /dev/null 2>&1

#=====
# symlinks

# SYMLINKS=() # empty array
# ln -sf ~/dotfiles/vim ~/.vim # -s symbolic -f force
# SYMLINKS+=('.vim') # append to SYMLINKS
# ln -sf ~/dotfiles/vimrc ~/.vimrc
# SYMLINKS+=('.vimrc')
# ln -sf ~/dotfiles/zshrc ~/.zshrc
# SYMLINKS+=('.zshrc')
# ln -sf ~/dotfiles/mac-tmux ~/.tmux
# SYMLINKS+=('.tmux')
# ln -sf ~/dotfiles/zsh/zsh_prompt ~/.zsh_prompt
# SYMLINKS+=('.zsh_prompt')
# ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
# SYMLINKS+=('.zshrc')
# ln -sf ~/dotfiles/config ~/.config
# SYMLINKS+=('.config')
# ln -sf ~/dotfiles/custom-configs/custom-snips ~/.vim/custom-snips
# SYMLINKS+=('.vim/custom-snips')
# ln -sf ~/dotfiles/homebrew/Brewfile ~/Brewfile
# SYMLINKS+=('Brewfile')

# look if a `gitconfig` exists inside `~/dotfiles/custom-configs`
# if we have custom-configs, we can put them inside the custom-config directory
# if [ -n "$(find ~/dotfiles/custom-configs -name gitconfig)" ]; then
#     ln -s ~/dotfiles/custom-configs/**/gitconfig ~/.gitconfig
# else
#   # otherwise, use the gitconfig found on the root of this dotfiles project
#     ln -s ~/dotfiles/gitconfig ~/.gitconfig
# fi
# SYMLINKS+=('.gitconfig') # append to the array

# if [ -n "$(find ~/dotfiles/custom-configs -name tmux.conf)" ]; then
#     ln -s ~/dotfiles/custom-configs/**/tmux.conf ~/.tmux.conf
# else
#     ln -s ~/dotfiles/mac-tmux/tmux.conf ~/.tmux.conf
# fi
# SYMLINKS+=('.tmux.conf')


# not sure. Probably dont need it
# hack for... I'm not even sure what... sqlite working in Python with pyenv?
# sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

# cd ~
# brew bundle
# cd -

#=====
# shell
#=====
# Change shell to /bin/zsh
# chsh -s /bin/zsh

# echo "Done"
