#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  USERNAME="${USERNAME:-$(whoami)}"
# Setup ohmyzsh and make zsh default shell
  sudo chsh "$USERNAME" -s "$(which zsh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  # powerlevel10k not working in wsl
  # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
  #   rcFile="$HOME/.zshrc"
  #   rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
  #   grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
