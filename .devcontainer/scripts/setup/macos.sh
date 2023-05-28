#!/usr/bin/env zsh
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
set -e
# Setup Developer Command Line tools
if ! git --version; then sudo xcode-select --install; fi
# Setup ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
rcFile="$HOME/.zshrc"
rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
rcLine='eval "$(/usr/local/bin/brew shellenv)"'
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/usr/local/bin/brew shellenv)"
brew update
# Install Homebrew packages
brew install sevenzip p7zip awk bash zsh file-formula gnu-sed coreutils curl wget grep bzip2 git git-lfs less sqlite gcc llvm openssl@1.1 openssl@3 nghttp2 openssh make cmake go python@3.11 ca-certificates speedtest-cli dos2unix shellcheck nss zlib zlib-ng age jq moreutils gedit asdf sigstore/tap/gitsign gh mkcert chezmoi postgresql@15 azure-cli awscli
# Setup post hombrew packages
brew link --force --overwrite postgresql@15
source /usr/local/opt/asdf/libexec/asdf.sh
rcLine='source /usr/local/opt/asdf/libexec/asdf.sh'
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Install Microsoft SQL tap and brews
brew tap --force-auto-update microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew tap --repair
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18
# Install Homebrew casks
brew install --cask iterm2
brew update --cask
# Run Homebrew doctor to check for errors
brew upgrade
brew upgrade --cask
brew cleanup
brew doctor
# Log into GitHub
if ! gh auth status; then gh auth login; fi
gh config set -h github.com git_protocol https
gh auth status
