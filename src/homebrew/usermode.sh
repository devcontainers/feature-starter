#!/usr/bin/env bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
#shellcheck disable=SC2086
# Install Homebrew package manager
set -e
if [ -e "${BREW_PREFIX}/bin/brew" ]; then
  echo "Homebrew already installed at ${BREW_PREFIX}"
else
  echo "Installing Homebrew..."
  . /etc/os-release
  while ! NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; do echo "Retrying"; done
fi

export BREW_PREFIX="${BREW_PREFIX}"
eval "$("$BREW_PREFIX/bin/brew" shellenv)"
# Check Homebrew was installed correctly and accessable
brew --version
# Update Homebrew
brew config
brew update
brew upgrade
# Setup recommended gcc, clang, and ruby
while ! brew install gcc ruby; do echo "Retrying"; done

# Run Brew doctor to check for errors
brew doctor

if [ -z "$BREWS" ]; then
  echo "No brews to install"
else
  echo "Installing brews: $BREWS..."
  while ! brew install --include-test $BREWS; do echo "Retrying"; done
fi
