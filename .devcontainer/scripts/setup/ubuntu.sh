#!/usr/bin/env bash
#shellcheck shell=bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  current_user="$(whoami)"
  IS_WSL=${IS_WSL:=false}
  updaterc() { line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo -e "$line" >> "$rc"; fi; done }
# Update max open files
  sudo sh -c "ulimit -n 1048576"
    line="$current_user soft nofile 4096"
    file=/etc/security/limits.conf
    sudo grep -qxF "$line" "$file" || echo "$line" | sudo tee --append "$file"
    line="$current_user hard nofile 1048576"
    sudo grep -qxF "$line" "$file" || echo "$line" | sudo tee --append "$file"
# Install apt-packages
  sudo apt update
  sudo apt install -y --fix-broken --fix-missing
  sudo apt upgrade -y
# Run post-build commands
  sudo -i bash -l -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-sudo.sh"
  bash -l -c "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-user.sh"
# Continue with devspace setup
  zsh -l -c "$DEVCONTAINER_SCRIPTS_ROOT/run/setup/devspace.sh"
# Log into GitHub
  if [ "$IS_WSL" != "true" ]; then
    if ! gh auth status; then gh auth login; fi
    gh config set -h github.com git_protocol https
    gh auth status
  fi
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
