#!/bin/sh

if [ ! -d "$HOME/.iggydotfiles" ]; then
  echo "Installing iggydotfiles"
  git clone --depth=1 git@github.com:iggredible/dotfiles.git "$HOME/.iggydotfiles"
  echo "DONE"
  rake install
else
  echo "iggydotfiles is already installed"
fi
