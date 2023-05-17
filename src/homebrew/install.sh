#!/usr/bin/env bash
#shellcheck disable=SC1091
#shellcheck disable=SC2089
#shellcheck disable=SC2181
#example=https://github.com/devcontainers/features/blob/main/src/azure-cli/install.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/tree/main/src/homebrew

BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
USERNAME="${USERNAME:-"automatic"}"
BREWS="${BREWS}"
FORCEED_BREWS="${FORCEED_BREWS}"

mustroot='Script must be run as root user.'
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$mustroot"
    exit 1
fi

ARCHITECTURE="$(dpkg --print-architecture)"
if [ "${ARCHITECTURE}" != "amd64" ] && [ "${ARCHITECTURE}" != "x86_64" ]; then
  echo "(!) Architecture $ARCHITECTURE unsupported"
  exit 1
fi

cleanup() {
  source /etc/os-release
  case "${ID}" in
    debian|ubuntu)
      rm -rf /var/lib/apt/lists/*
    ;;
  esac
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive

echo "(*) Installing Homebrew..."
. /etc/os-release

# Clean up
cleanup

# Install dependencies if missing
check_packages \
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
  uuid-runtime
  
# Install Homebrew package manager
if [ -e "${BREW_PREFIX}" ]; then
  echo "Homebrew already installed at ${BREW_PREFIX}"
else
  echo "Installing Homebrew..."
  . /etc/os-release
  while ! NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; do echo "Retrying Homebrew install..."; done
  # No need to restart after Homebrew install
  eval "$("$BREW_PREFIX/bin/brew" shellenv)"
  # Check Homebrew was installed correctly and accessable
  brew --version
  # Update Homebrew
  brew update
  brew upgrade
  # Setup bash for Homebrew
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
  # Setup zsh for Homebrew
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshenv
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zprofile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
  # Setup recommended gcc
  brew install gcc
fi

# Brew config
brew config
# Run Brew doctor to check for errors
brew doctor

if [ -z "$BREWS" ]; then
  echo "No brews to install"
else
  echo "Installing brews: $BREWS..."
  brew install $BREWS
fi

if [ -z "$FORCED_BREWS" ]; then
  echo "No forced brews to install"
else
  echo "Installing forced brews: $FORCED_BREWS..."
  brew install --force $FORCED_BREWS
fi

# Clean up
cleanup

echo "Done!"
