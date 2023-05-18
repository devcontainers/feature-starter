#!/usr/bin/env bash
#shellcheck disable=SC1091
#shellcheck disable=SC2089
#shellcheck disable=SC2181
#example=https://github.com/devcontainers/features/blob/main/src/azure-cli/install.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/tree/main/src/homebrew
set -e
BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"

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
  uuid-runtime \
  build-essential
  
# Install Homebrew package manager
# chown -R "${USERNAME}" "${BREW_PREFIX}"
sudo -u "$USERNAME" BREW_PREFIX="$BREW_PREFIX" BREWS="$BREWS" FORCED_BREWS="$FORCED_BREWS" ./usermode.sh

# Clean up
cleanup

echo "Done!"
