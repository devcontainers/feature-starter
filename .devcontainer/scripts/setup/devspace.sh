#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC1090
#shellcheck disable=SC2016
set -e
# Refresh environment profile
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# Fix for git-credential-manager
# TODO: Finish fixing
# export GCM_CREDENTIAL_STORE=cache
# rcLine="export GCM_CREDENTIAL_STORE=cache"
# rcFile=~/.bashrc
# grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
# rcFile=~/.zshrc
# grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | tee --append "$rcFile"
# sudo rm -rf /usr/share/dotnet || false
# sudo ln -s /usr/local/dotnet/6.0.408 /usr/share/dotnet
# Test all tools are installed
docker --version
docker-compose --version
bash --version
zsh --version
pwsh --version
git --version
git-lfs --version
# TODO: Fix on devspace
# git-credential-manager --version
gitsign --version
gitsign-credential-cache --version
gh --version
dotnet --version
nvm --version
nvm version
npm --version
npm version
node --version
brew --version
age --version
age-keygen --version
mkcert --version
chezmoi --version
psql --version
devcontainer --version
# Setup git credential manager
# TODO: Fix on devspace
# git-credential-manager configure
# git-credential-manager diagnose
# Adding GH .ssh known hosts
mkdir -p ~/.ssh/
touch ~/.ssh/known_hosts
bash -c eval "$(ssh-keyscan github.com >> ~/.ssh/known_hosts)"
