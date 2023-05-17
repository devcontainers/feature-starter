#!/usr/bin/env bash
#shellcheck source=/dev/null
source /etc/os-release

BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
USERNAME="${USERNAME:-"automatic"}"

ARCHITECTURE="$(uname -m)"
if [ "${ARCHITECTURE}" != "amd64" ] && [ "${ARCHITECTURE}" != "x86_64" ]; then
  echo "(!) Architecture $ARCHITECTURE unsupported"
  exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
  echo -e 'Script must not be run as root.'
  exit 1
fi

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
    echo -e 'Script must not be run as root.'
    exit 1
  fi
elif [ "${USERNAME}" = "none" ] || ! id -u "${USERNAME}" > /dev/null 2>&1; then
  echo -e 'Script must not be run as root.'
  exit 1
fi

# Install Homebrew
if [ -e "${BREW_PREFIX}" ]; then
  echo "Homebrew already installed at ${BREW_PREFIX}"
  exit 0
fi


# Install Homebrew package manager
echo "Installing Homebrew..."
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
echo "Done!"
