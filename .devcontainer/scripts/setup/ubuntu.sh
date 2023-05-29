#!/usr/bin/env bash
#shellcheck shell=bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
  current_user="$(whoami)"
  IS_WSL=${IS_WSL:=false}
# Update max open files
  sudo sh -c "ulimit -n 1048576"
    line="$current_user soft nofile 4096"
    file=/etc/security/limits.conf
    sudo grep -qxF "$line" "$file" || echo "$line" | sudo tee --append "$file"
    line="$current_user hard nofile 1048576"
    sudo grep -qxF "$line" "$file" || echo "$line" | sudo tee --append "$file"
# Setup environment
  # shellcheck disable=SC2016
  updaterc 'source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment'
# Install apt-packages
  sudo apt update
  sudo apt install -y --fix-broken --fix-missing
  sudo apt upgrade -y
# Run post-build commands
  sudo -i bash -l -c "\"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup/devspace post-build-sudo"
  bash -l -c "\"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup/devspace post-build-user"
# Continue with devspace setup
  bash -l -c "\"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup devspace"
# Log into GitHub
  if [ "$IS_WSL" != "true" ]; then
    if ! gh auth status; then gh auth login; fi
    gh config set -h github.com git_protocol https
    gh auth status
    # TODO: Figure out if this is needed on linux
    # Setup git credential manager
      # git-credential-manager configure
      # git-credential-manager diagnose
  fi
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
