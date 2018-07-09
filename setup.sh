#!/usr/bin/env bash

set exuo -pipefail

function green() {
  echo -e "\e[32m"$1"\e[39m"
}

green 'Installing dependencies ...'
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install --yes \
  gcc \
  git \
  htop \
  libxtst6 \
  make \
  tar \
  tmux \
  xserver-xephyr \
  vim

green 'Setting up directories ...'
DEV_DIR=~/Development
mkdir -p "$DEV_DIR"

green 'Setting up dotfiles ...'
DOTFILES_DIR=~/Development/dotfiles
rm -rf "$DOTFILES_DIR" && mkdir -p "$DOTFILES_DIR" && cd "$DOTFILES_DIR"
git clone git@github.com:nicktrav/dotfiles.git .
git fetch origin nickt.debian && git checkout nickt.debian
./install.sh


green 'Installing Java ...'
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install --y openjdk-9-jdk

green 'Installing Rust ...'
curl -Ssf https://sh.rustup.rs | sh -s -- -y

# Install IntelliJ
#cd ~/Downloads && \
#curl -L -o intellij.tar.gz \
#https://download.jetbrains.com/idea/ideaIC-2018.1.5.tar.gz &&
#tar xzf intellij.tar.gz
