#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
IS_WSL=true "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup ubuntu
# Install WSL Utilties
# https://github.com/wslutilities/wslu
sudo apt update
sudo apt upgrade -y
sudo apt install -y wslu
# Setup windows browser as default
alias xdg-open=wslview
  rcSed='s/^alias xdg-open=.*$/alias xdg-open=wslview/'
  sed -i "$rcSed" "$HOME/.bashrc"
  sed -i "$rcSed" "$HOME/.zshrc"
export BROWSER=wslview
  rcSed='s/^export BROWSER=.*$/export BROWSER=wslview/'
  sed -i "$rcSed" "$HOME/.bashrc"
  sed -i "$rcSed" "$HOME/.zshrc"
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
# Setup git credential manager
git-credential-manager configure
git-credential-manager diagnose
# Setup environment
source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
# WSLg GPU acceleration
# glxinfo
echo "WARNING: Please restart shell to get latest environment variables"
