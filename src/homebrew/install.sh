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
USERNAME="${USERNAME:-"automatic"}"

source /etc/os-release

# If in automatic mode, determine if a user already exists, if not use vscode
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    if [ "${_REMOTE_USER}" != "root" ]; then
        USERNAME="${_REMOTE_USER}"
    else
        USERNAME=""
        POSSIBLE_USERS=("devcontainer" "vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
        for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
            if id -u ${CURRENT_USER} > /dev/null 2>&1; then
                USERNAME=${CURRENT_USER}
                break
            fi
        done
        if [ "${USERNAME}" = "" ]; then
            USERNAME=vscode
        fi
    fi
fi

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

BREW_PREFIX="$BREW_PREFIX" BREWS="$BREWS" su "$USERNAME" -c ./usermode.sh
echo "Done!"
