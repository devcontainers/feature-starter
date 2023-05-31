#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source /etc/bash.bashrc
# Update apt-packages
  while ! (
    apt update
    apt upgrade -y
    apt install -y --install-recommends --fix-broken --fix-missing
    apt install -y --install-recommends sudo systemd mawk gawk bash zsh file sed curl wget grep bzip2 build-essential make cmake gcc g++ less locales
    apt install -y --install-recommends patch tzdata uuid-runtime netbase python3 dotnet-sdk-6.0 dotnet-sdk-7.0 git apt-transport-https ca-certificates age
    apt install -y --install-recommends openssl openssh-client procps checkinstall dos2unix software-properties-common libnss3 libnss3-tools shellcheck jq moreutils
    apt install -y --install-recommends bash-completion zlib1g-dev speedtest-cli powerline fonts-powerline fonts-dejavu-core gedit gimp nautilus vlc x11-apps
  ) do echo "Retrying apt-packages..."; done
