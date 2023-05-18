#!/usr/bin/env bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
#shellcheck disable=SC2086
#shellcheck disable=SC2089
#shellcheck disable=SC2181
#example=https://github.com/devcontainers/features/blob/main/src/azure-cli/install.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/tree/main/src/homebrew
set -e
BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"

source /etc/os-release

# Checks if packages are installed and installs them if not
check_packages() {
  if ! dpkg -s "$@" > /dev/null 2>&1; then
      if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
          echo "Running apt-get update..."
          apt-get update -y
      fi
      apt-get -y install "$@"
  fi;
}

export DEBIAN_FRONTEND=noninteractive

echo "(*) Installing Homebrew..."

# Install dependencies if missing
while ! check_packages \
  bzip2 \
  ca-certificates \
  curl \
  file \
  fonts-dejavu-core \
  g++ \
  git \
  less \
  libz-dev \
  locales \
  make \
  netbase \
  openssh-client \
  patch \
  sudo \
  tzdata \
  uuid-runtime \
  build-essential; do echo "Retrying"; done

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
echo 'eval "$("$BREW_PREFIX/bin/brew" shellenv)"' >> ~/.bashrc
echo 'eval "$("$BREW_PREFIX/bin/brew" shellenv)"' >> ~/.zshrc

# Check Homebrew was installed correctly and accessable
brew --version
# Update Homebrew
brew config
brew update
brew upgrade
# Setup recommended gcc
while ! brew install gcc; do echo "Retrying"; done

# Run Brew doctor to check for errors
brew doctor

if [ -z "$BREWS" ]; then
  echo "No brews to install"
else
  echo "Installing brews: $BREWS..."
  while ! brew install --include-test $BREWS; do echo "Retrying"; done
fi

echo "Done!"
