#!/usr/bin/env bash
set -e

source functions.sh

check_and_install ca-certificates

# check if zsh is installed
if which zsh; then
  echo "ZSH is already installed. Great!"
else
  echo "ZSH needs to be installed"
  check_and_install zsh
fi

# set zsh as default shell for the remote user
chsh -s "$(which zsh)" "$_REMOTE_USER"

if [ "$_REMOTE_USER" = "root" ]; then
  USER_LOCATION="/root"
else
  USER_LOCATION="/home/$_REMOTE_USER"
fi

# ensure oh-my-zsh installed
if [ "$USEOHMYZSH" == "true" ] && ! [ -d "$USER_LOCATION"/.oh-my-zsh ]; then
  check_and_install wget git
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi
