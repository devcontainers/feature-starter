#!/usr/bin/env bash
#shellcheck disable=SC1091
#shellcheck disable=SC2089
#shellcheck disable=SC2181
#example=https://github.com/devcontainers/features/blob/main/src/azure-cli/install.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/tree/main/src/homebrew
mustroot='Script must be run as root user.'
notroot='Script must be run as non-root user.'
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$mustroot"
    exit 1
fi

BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
USERNAME="${USERNAME:-"automatic"}"

ARCHITECTURE="$(dpkg --print-architecture)"
if [ "${ARCHITECTURE}" != "amd64" ] && [ "${ARCHITECTURE}" != "x86_64" ]; then
  echo "(!) Architecture $ARCHITECTURE unsupported"
  exit 1
fi

cleanup() {
  source /etc/os-release
  case "${ID}" in
    debian|ubuntu)
      sudo rm -rf /var/lib/apt/lists/*
    ;;
  esac
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            sudo apt-get update -y
        fi
        sudo apt-get -y install --no-install-recommends "$@"
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
  
# Determine the appropriate non-root user
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
  USERNAME=""
  POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
  for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
    if id -u "${CURRENT_USER}" > /dev/null 2>&1; then
      USERNAME=${CURRENT_USER}
      break
    fi
  done
  if [ "${USERNAME}" = "" ]; then
    echo -e "$notroot"
    exit 1
  fi
elif [ "${USERNAME}" = "none" ] || ! id -u "${USERNAME}" > /dev/null 2>&1; then
  echo -e "$notroot"
  exit 1
fi

# Install Homebrew package manager
if [ -e "${BREW_PREFIX}" ]; then
  echo "Homebrew already installed at ${BREW_PREFIX}"
  exit 0
fi

echo "Installing Homebrew..."
. /etc/os-release
while ! NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; do echo "Retrying Homebrew install..."; done
# No need to restart after Homebrew install
eval "$("$BREW_PREFIX/bin/brew" shellenv)"
# Check Homebrew was installed correctly and accessable
brew --version
# Setup bash for Homebrew
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
# Setup zsh for Homebrew
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshenv
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zprofile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
# Brew config
brew config
# Run Brew doctor to check for errors
brew doctor

# Clean up
cleanup

echo "Done!"
