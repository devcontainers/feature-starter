#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source /etc/bash.bashrc
# Update apt-packages
  apt update
  apt upgrade -y
  apt install -y --install-recommends --fix-broken --fix-missing
  apt install -y --install-recommends sudo systemd mawk gawk bash zsh file sed curl wget grep bzip2 build-essential make cmake gcc g++ less locales
  apt install -y --install-recommends patch tzdata uuid-runtime netbase dotnet-sdk-6.0 dotnet-sdk-7.0 git apt-transport-https ca-certificates age
  apt install -y --install-recommends openssl openssh-client procps checkinstall dos2unix software-properties-common libnss3 libnss3-tools shellcheck jq moreutils
  apt install -y --install-recommends bash-completion zlib1g-dev speedtest-cli powerline fonts-powerline fonts-dejavu-core gedit gimp nautilus vlc x11-apps
# Install docker completions
  rm -rf /etc/bash_completion.d/docker.sh || true
  mkdir -p /etc/bash_completion.d
  touch /etc/bash_completion.d/docker.sh
  curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
  rm -rf /usr/share/zsh/vendor-completions/_docker || true
  mkdir -p /usr/share/zsh/vendor-completions
  touch /usr/share/zsh/vendor-completions/_docker
  curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/docker -o /usr/share/zsh/vendor-completions/_docker
# Install Microsoft Edge
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
  install -o root -g root -m 644 /tmp/microsoft.gpg /usr/share/keyrings/
  sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft.list'
  rm /tmp/microsoft.gpg
  apt update
  apt install -y --install-recommends microsoft-edge-stable
  rm -rf /etc/apt/sources.list.d/microsoft-edge.list
# Update apt-packages
  apt install -y --install-recommends --fix-broken --fix-missing
  apt update
  apt upgrade -y
# Cleanup apt-packages
  apt autoclean -y
  apt autoremove -y
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
