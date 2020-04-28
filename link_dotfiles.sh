#!/bin/bash

function backup() {
  if [ -e "$1" ]; then
    echo "$1 exists, made a backup"
    mv "$1" "$1.backup"
  fi
}

backup ~/.gitconfig
ln -s ~/dotfiles/gitconfig_global ~/.gitconfig

backup ~/.gvimrc
ln -s ~/dotfiles/gvimrc ~/.gvimrc 

backup ~/.irbrc
ln -s ~/dotfiles/irbrc ~/.irbrc

backup ~/.vimrc
ln -s ~/dotfiles/vimrc ~/.vimrc

backup ~/.vim
ln -s ~/dotfiles/vim ~/.vim

backup ~/.zshrc
ln -s ~/dotfiles/zshrc ~/.zshrc

backup ~/.config/fish
ln -s ~/dotfiles/fish_config ~/.config/fish
