#!/usr/bin/env bash
#shellcheck shell=bash
# init
  set -e
  updaterc() { line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Test all tools are installed
  docker --version
  docker-compose --version
  bash --version
  zsh --version
  pwsh --version
  git --version
  git-lfs --version
  git-credential-manager --version
  gitsign --version
  gitsign-credential-cache --version
  gh --version
  dotnet --version
  # TODO: This seems wrong, why do I need to do this?
  # shellcheck disable=SC2016
  updaterc 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
  # shellcheck disable=SC2016
  updaterc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
  nvm --version
  nvm version
  npm --version
  npm version
  node --version
  brew --version
  asdf --version
  age --version
  age-keygen --version
  mkcert --version
  chezmoi --version
  psql --version
  devcontainer --version
# Done
  echo "Devspace setup complete!"
