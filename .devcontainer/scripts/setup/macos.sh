#!/usr/bin/env zsh
#shellcheck shell=bash
# init
# Run post-build commands
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-user.sh"
# Continue with devspace setup
  "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Log into GitHub
  if ! gh auth status; then gh auth login; fi
  gh config set -h github.com git_protocol https
  gh auth status
# Done
  echo "Please restart shell to get latest environment variables"
