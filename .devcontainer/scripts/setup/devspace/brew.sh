#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  updaterc() { local line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
  HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}
  os=$(uname -s)
# Setup Homebrew
  sudo echo "sudo cached for noninteractive homebrew install"
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  cat "$HOME/.bashrc"
  updaterc "eval \"\$(\"$HOMEBREW_PREFIX/bin/brew\" shellenv)\""
  # Install taps
    brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
  # Repair and Update if needed
    brew update
    brew tap --repair
  # Install Homebrew packages
    # linux only brews
      #TODO: Fix
      if [ "$os" == "Linux" ]; then HOMEBREW_ACCEPT_EULA=Y brew install procps systemd; fi
    # These work on all brew platforms
      HOMEBREW_ACCEPT_EULA=Y brew install sevenzip p7zip awk ca-certificates bash zsh oh-my-posh file-formula gnu-sed coreutils grep curl wget bzip2 less
      HOMEBREW_ACCEPT_EULA=Y brew install zlib zlib-ng buf protobuf grpc dos2unix git git-lfs sigstore/tap/gitsign-credential-cache sigstore/tap/gitsign gh asdf
      HOMEBREW_ACCEPT_EULA=Y brew install jq moreutils gcc make cmake cmake-docs llvm dotnet dotnet@6 mono go python@3.11 nss openssl@3 openssl@1.1 openssh age
      HOMEBREW_ACCEPT_EULA=Y brew install nghttp2 mkcert shellcheck speedtest-cli mono-libgdiplus chezmoi sqlite sqlite-utils postgresql@15 azure-cli awscli
      HOMEBREW_ACCEPT_EULA=Y brew install msodbcsql18 mssql-tools18 gedit
  # Upgrade all packages
    brew update
    brew upgrade
  # Setup post hombrew packages
    brew link --force --overwrite postgresql@15 openssl@3
    # shellcheck disable=SC2016
    updaterc "export PATH=\"$HOMEBREW_PREFIX/opt/python/libexec/bin:\$PATH\""
    updaterc "source \"$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh\""
    updaterc "export MONO_GAC_PREFIX=\"$HOMEBREW_PREFIX\""
    # shellcheck disable=SC2016
    updaterc "export PATH=\"$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:\$PATH\""
  # Run Homebrew cleanup and doctor to check for errors
    brew cleanup
    brew doctor
