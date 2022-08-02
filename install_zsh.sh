#!/usr/bin/env bash
if command -v apt > /dev/null; then
  sudo apt install git curl zsh
fi
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh > install_omzsh.sh
chmod +x install_omzsh.sh
./install_omzsh.sh -y
mv ~/.zshrc ~/.zshrc-omz
wget bit.ly/alourie-zshrc -O .zshrc
zsh
