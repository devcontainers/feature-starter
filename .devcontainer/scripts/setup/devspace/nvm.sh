#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  updaterc() { local line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
# Setup nvm
  updaterc 'export NVM_SYMLINK_CURRENT="true"'
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  # shellcheck disable=SC2016
  updaterc 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
  # shellcheck disable=SC2016
  updaterc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
  # Create default package.json
  package_json=package.json
  default_package_json='{ "name": "devspace" }'
  echo "$default_package_json" | sudo tee $package_json
  # Install Node.js latest and lts
    nodes=('node' '--lts')
    packages=('npm-check-updates' 'corepack' '@npmcli/fs' '@devcontainers/cli' 'dotenv-cli' 'typescript')
    for node in "${nodes[@]}"; do nvm install "$node"; nvm use "$node"; node --version; npm update -g npm; npm i -g "${packages[@]}"; ncu -u; done
    nvm use node
  sudo rm -rf $package_json
