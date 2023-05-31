#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Adding GH .ssh known hosts
  mkdir -p "$HOME/.ssh/"
  touch "$HOME/.ssh/known_hosts"
  bash -c eval "$(ssh-keyscan github.com >> "$HOME/.ssh/known_hosts")"
