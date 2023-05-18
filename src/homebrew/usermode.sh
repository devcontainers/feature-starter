#!/usr/bin/env bash
#shellcheck source=/dev/null
set -e
# Install Homebrew package manager
if [ -e "${BREW_PREFIX}" ]; then
  echo "Homebrew already installed at ${BREW_PREFIX}"
else
  echo "Installing Homebrew..."
  . /etc/os-release
  while ! NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; do echo "Retrying"; done
fi

# No need to restart after Homebrew install
export PATH="$PATH:$BREW_PREFIX/bin"
eval "$("$BREW_PREFIX/bin/brew" shellenv)"
# Check Homebrew was installed correctly and accessable
brew --version
# Update Homebrew
brew config
brew update
brew upgrade
# Setup recommended gcc
brew install gcc

# Run Brew doctor to check for errors
brew doctor

if [ -z "$BREWS" ]; then
  echo "No brews to install"
else
  echo "Installing brews: $BREWS..."
  brew install --include-test "$BREWS"
fi

if [ -z "$FORCED_BREWS" ]; then
  echo "No forced brews to install"
else
  echo "Installing forced brews: $FORCED_BREWS..."
  brew install --include-test --force "$FORCED_BREWS"
fi
