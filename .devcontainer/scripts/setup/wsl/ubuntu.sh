#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
# init
  set -e
  updaterc() {
    line="$1"
    eval "$line"
    echo "Updating ~/.bashrc and ~/.zshrc..."
    rcs=("$HOME/.bashrc" "$HOME/.zshrc")
    for rc in "${rcs[@]}"; do
      if [[ "$(cat "$rc")" != *"$line"* ]]; then
        echo -e "$line" >> "$rc"
      fi
    done
  }
  updaterc 'export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"'
  updaterc 'export PATH="$HOMEBREW_PREFIX/bin:$PATH"'
  updaterc 'eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"'
# Run base ubuntu setup
  IS_WSL=true source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup ubuntu
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
# Refresh environment
  source "$HOME/.bashrc"
  source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
# Log into GitHub
  if ! gh auth status; then gh auth login; fi
  gh config set -h github.com git_protocol https
  gh auth status
  # Setup git credential manager
    git-credential-manager configure
    git-credential-manager diagnose
# WSLg GPU acceleration
  # glxinfo
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
