#!/usr/bin/env bash
#shellcheck shell=bash
set -e
# Install docker completions
sudo rm -rf /etc/bash_completion.d/docker.sh || true
sudo mkdir -p /etc/bash_completion.d
sudo touch /etc/bash_completion.d/docker.sh
suod curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
sudo rm -rf /usr/share/zsh/vendor-completions/_docker || true
sudo mkdir -p /usr/share/zsh/vendor-completions
sudo touch /usr/share/zsh/vendor-completions/_docker
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/docker -o /usr/share/zsh/vendor-completions/_docker
# Install Microsoft Edge
sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
sudo install -o root -g root -m 644 /tmp/microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft.list'
sudo rm /tmp/microsoft.gpg
sudo apt update
sduo apt install -y microsoft-edge-beta
sudo apt install --fix-broken --fix-missing -y
# Update
sudo apt update
sudo apt upgrade -y
# Cleanup
sudo apt autoclean -y
sudo apt autoremove -y
# Make Edge the default browser
export BROWSER=/usr/bin/microsoft-edge-beta
rcLine=export BROWSER=/usr/bin/microsoft-edge-beta
rcFile=$HOME/.bashrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
rcFile=$HOME/.zshrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Make trusted root CA then install and trust it
mkcert -install
dotnet dev-certs https --trust
