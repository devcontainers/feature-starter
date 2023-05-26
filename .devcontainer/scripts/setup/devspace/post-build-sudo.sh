#!/usr/bin/env bash
#shellcheck shell=bash
set -e
# Refresh environment profile
source /etc/bash.bashrc
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
apt install -y microsoft-edge-beta
apt install --fix-broken --fix-missing -y
rm -rf /etc/apt/sources.list.d/microsoft-edge-beta.list
# Update
apt update
apt upgrade -y
# Cleanup
apt autoclean -y
apt autoremove -y
# Make trusted root CA then install and trust it
mkcert -install
dotnet dev-certs https --trust
