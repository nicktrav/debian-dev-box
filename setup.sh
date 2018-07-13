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
  xserver-xephyr \
  vim

green 'Setting up directories ...'
DEV_DIR=~/Development
mkdir -p "$DEV_DIR"

green 'Building tmux ...'

sudo apt-get install \
  autogen \
  automake \
  libevent-dev \
  libncurses5-dev \
  pkg-config

cd "$DEV_DIR" && git clone git@github.com:tmux/tmux.git
cd tmux && \
  sh autogen.sh && \
  autoreconf -i --force && ./configure && make && \
  sudo make install

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
