#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC1090
#shellcheck disable=SC2016
set -e
# Refresh environment profile
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# TODO: Move to homebrew with taps option
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18
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
# TODO: Fix
# git-credential-manager configure
# git-credential-manager diagnose
# Adding GH .ssh known hosts
mkdir -p "$HOME/.ssh/"
touch "$HOME/.ssh/known_hosts"
bash -c eval "$(ssh-keyscan github.com >> "$HOME/.ssh/known_hosts")"
echo "Don't forget to run 'gh auth login'"
echo "WARNING: Please restart shell to get latest environment variables"
