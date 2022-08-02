#!/usr/bin/env bash
if command -v apt > /dev/null; then
  sudo apt install git curl zsh
fi
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc-omz
wget bit.ly/alourie-zshrc -O .zshrc
zsh
