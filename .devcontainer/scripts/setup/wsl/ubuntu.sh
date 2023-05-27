#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
IS_WSL=true "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup ubuntu
# Install WSL Utilties
# https://github.com/wslutilities/wslu
sudo apt update
sudo apt upgrade -y
audo apt install -y wslu
# Setup windows browser as default
alias xdg-open=wslview
export BROWSER=wslview
sed -i 's/^export BROWSER=.*$/export BROWSER=wslview/' "$HOME/.bashrc"
sed -i 's/^export BROWSER=.*$/export BROWSER=wslview/' "$HOME/.zshrc"
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
# Setup git credential manager
# TODO: Fix
# git-credential-manager configure
# git-credential-manager diagnose
# Setup environment
source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
# WSLg GPU acceleration
# glxinfo
echo "WARNING: Please restart shell to get latest environment variables"
