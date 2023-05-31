#!/usr/bin/env zsh
#shellcheck shell=bash
# init
  # shellcheck source=/dev/null
  source "$HOME/.zshrc"
# Setup Developer Command Line tools
  if ! git --version; then sudo xcode-select --install; fi
# Run post-build commands
  # shellcheck source=/dev/null
  export HOMEBREW_PREFIX="/usr/local"
  bash -l -c "source $DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-user.sh"
  source "$HOME/.zshrc"
# Continue with devspace setup
  "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
# Log into GitHub
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# Done
  echo "Please restart shell to get latest environment variables"
