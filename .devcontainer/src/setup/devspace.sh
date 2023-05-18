#!/usr/bin/env zsh
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC1090
#shellcheck disable=SC2016
set -e
# Setup PATH
# PostgreSQL client psql
PATH="/home/linuxbrew/.linuxbrew/opt/libpq/bin:$PATH"
# dotnet cli tools
export PATH=$PATH:~/.dotnet/tools
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# Setup ENV
# Setup completions
autoload -U +X compinit && compinit
# Check all tools are installed
docker --version
docker-compose --version
bash --version
zsh --version
pwsh --version
git --version
git-lfs --version
gitsign-credential-cache --version
gh --version
dotnet --version
nvm version
node --version
npm --version
npm version
brew --version
age --version
age-keygen --version
mkcert --version
chezmoi --version
psql --version
# dotnet zsh profile setup
echo 'export PATH=$PATH:~/.dotnet/tools' >> ~/.zshrc
# kubectl completion zsh profile setup
source='source <(kubectl completion zsh)'
grep -qxF "$source"  ~/.zshrc || echo "$source" >>  ~/.zshrc
# Make container a Root CA and trust it
mkcert -install
dotnet dev-certs https --trust
# Adding GH .ssh known hosts
mkdir -p ~/.ssh/
touch ~/.ssh/known_hosts
bash -c eval "$(ssh-keyscan github.com >> ~/.ssh/known_hosts)"
# Update package managers
npm update -g npm
# https://stackoverflow.com/questions/33553082/how-can-i-update-all-npm-packages-modules-at-once
npm i -g npm-check-updates && ncu -u && npm i
# Install needed tools, packages, modules, brew, etc...
# Install devcontainer cli
npm install -g "@devcontainers/cli"
# Install git-credential-manager
tool=git-credential-manager && if ! (dotnet tool install -g "$tool"); then dotnet tool update -g "$tool"; fi
# Install dotenv cli
npm install -g "dotenv-cli"
# Install Set-PsEnv module
pwsh -command Install-Module Set-PsEnv -Force -AcceptLicense
# Install Pester module
pwsh -command Install-Module "Pester" -Force -AcceptLicense
# TODO: Fix
# Setup git credential manager
git-credential-manager configure || true
git-credential-manager diagnose || true
# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
# TODO: Fix
#sudo rm -rf /tmp/google-chrome-stable_current_amd64.deb
# Install Edge
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
sudo install -o root -g root -m 644 /tmp/microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
# TODO: Fix
#sudo rm /tmp/microsoft.gpg
sudo apt update
sudo apt install microsoft-edge-dev
sudo apt update
sudo apt upgrade --fix-broken -y
