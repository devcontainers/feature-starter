#!/usr/bin/env zsh
#shellcheck shell=bash
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
brew install sevenzip p7zip awk bash zsh file-formula gnu-sed curl wget grep bzip2 git git-lfs less sqlite gcc llvm openssl@1.1 openssl@3 nghttp2 openssh make cmake go python@3.11 ca-certificates speedtest-cli dos2unix shellcheck procps nss zlib zlib-ng age jq moreutils gedit asdf sigstore/tap/gitsign gh mkcert chezmoi postgresql@15 azure-cli awscli
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18
