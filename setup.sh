#!/usr/bin/env bash

# Mac installation assumes that homebrew is already installed

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

