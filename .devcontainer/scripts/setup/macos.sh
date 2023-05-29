#!/usr/bin/env zsh
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016,SC2143
# init
  set -e
  rcFile="$HOME/.zshrc"
# Setup Developer Command Line tools
  if ! git --version; then sudo xcode-select --install; fi
# Setup ohmyzsh
  sudo chsh "$(whoami)" -s "$(which zsh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
    rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup environment
  source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
    rcLine="source \"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup environment"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup Homebrew
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval "$(/usr/local/bin/brew shellenv)"
    rcLine='eval "$(/usr/local/bin/brew shellenv)"'
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Test
    brew --version
  # Repair and Update if needed
    brew tap --repair
    brew update
  # Install Homebrew packages
    HOMEBREW_ACCEPT_EULA=Y brew install sevenzip p7zip awk bash zsh oh-my-posh file-formula gnu-sed coreutils grep curl wget bzip2 less buf protobuf grpc asdf
    HOMEBREW_ACCEPT_EULA=Y brew install git git-lfs sigstore/tap/gitsign gh sqlite sqlite-utils gcc llvm openssl@1.1 openssl@3 nghttp2 openssh make cmake cmake-docs
    HOMEBREW_ACCEPT_EULA=Y brew install mkcert go python@3.11 ca-certificates speedtest-cli dos2unix shellcheck nss mono-libgdiplus zlib zlib-ng age jq moreutils
    HOMEBREW_ACCEPT_EULA=Y brew install chezmoi postgresql@15 azure-cli awscli microsoft/mssql-release/msodbcsql18 microsoft/mssql-release/mssql-tools18 gedit
    alias sed=gsed
      sed -i 's/^alias sed=.*$/alias sed=gsed/' "$HOME/.bashrc"
      sed -i 's/^alias sed=.*$/alias sed=gsed/' "$HOME/.zshrc"
    git lfs install
    git lfs install --system
    brew update
    brew upgrade
  # Setup post hombrew packages
    brew link --force --overwrite postgresql@15
    source /usr/local/opt/asdf/libexec/asdf.sh
      rcLine='source /usr/local/opt/asdf/libexec/asdf.sh'
      grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Install Homebrew casks
    brew install --cask iterm2
    brew update --cask
    brew upgrade --cask
  # Run Homebrew doctor to check for errors
    brew cleanup
    brew doctor
  # Test
    bash --version
    zsh --version
    mkcert --version
    chezmoi --version
    gitsign-credential-cache --version
    psql --version
    asdf --version
# Setup nvm
  export NVM_SYMLINK_CURRENT="true"
    rcLine='export NVM_SYMLINK_CURRENT="true"'
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  export NVM_DIR="$NVM_DIR"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  # Test
    nvm version
  # Install Node.js latest and lts
    nvm install node
    nvm install --lts
    # Update lts npm
      nvm use --lts
      npm update -g npm
      npm --version
      npm version
    # Update lts npm packages
      npm i -g @npmcli/fs
      npm i -g @devcontainers/cli
      npm i -g dotenv-cli
      npm i -g typescript
      npm i -g npm-check-updates
      ncu -u
      npm i
    # Test
      node --version
      npm --version
    # Update latest npm
      nvm use node
      node --version
      npm update -g npm
      npm --version
      npm version
    # Update latest npm packages
      npm i -g @npmcli/fs
      npm i -g @devcontainers/cli
      npm i -g dotenv-cli
      npm i -g typescript
      npm i -g npm-check-updates
      ncu -u
      npm i
    # Test
      node --version
      npm --version
# Setup dotnet
  asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git || true
  asdf plugin update --all
  preview="$(asdf list all dotnet-core 8)"
  current="$(asdf list all dotnet-core 7)"
  lts="$(asdf list all dotnet-core 6)"
  asdf install dotnet-core "$preview"
  asdf install dotnet-core "$current"
  asdf install dotnet-core "$lts"
  asdf global dotnet-core "$preview"
  asdf reshim
  asdf info
  source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"
    rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"'
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Test
    dotnet --version
    dotnet --info
  # Setup dotnet workloads
    dotnet workload install --include-previews wasi-experimental
    # Clean, repair, and update
      dotnet workload clean
      dotnet workload update
      dotnet workload repair
  # Setup dotnet tools
    PATH="$HOME/.dotnet/tools:$PATH"
    rcLine='PATH="$HOME/.dotnet/tools:$PATH"'
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    tools=('powershell' 'git-credential-manager')
    for tool in "${tools[@]}"; do
      if [ -z "$(dotnet tool list -g | grep -q "$tool")" ]; then dotnet tool update -g "$tool"; else dotnet tool install -g "$tool"; fi
    done
    # Test
      pwsh --version
      git-credential-manager --version
# pwsh modules
  modules=('Pester' 'Set-PsEnv')
  install_modules() {
    local shell_command=$1
    $shell_command -Command "Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber; Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber -AllowPrerelease; Set-Alias -Name awk -Value gawk;"
    for module in "${modules[@]}"; do
      $shell_command -Command "Install-Module -Name $module -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber;"
    done
  }
  # PowerShell Core (pwsh)
    if command -v pwsh > /dev/null; then
      install_modules "pwsh"
    else
      echo "PowerShell Core is not installed"
    fi
  # PowerShell Core Preview (pwsh-preview)
    if command -v pwsh-preview > /dev/null; then
      install_modules "pwsh-preview"
    else
      echo "PowerShell Core Preview is not installed"
    fi
# Test docker
  docker --version
  docker-compose --version
# Adding GH .ssh known hosts
  mkdir -p "$HOME/.ssh/"
  touch "$HOME/.ssh/known_hosts"
  bash -c eval "$(ssh-keyscan github.com >> "$HOME/.ssh/known_hosts")"
# Make trusted root CA then install and trust it
  mkcert -install
  dotnet dev-certs https --trust
# Refresh environment
  source "$HOME/.zshrc"
  source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
# Log into GitHub
  if ! gh auth status; then gh auth login; fi
  gh config set -h github.com git_protocol https
  gh auth status
  # Setup git credential manager
    git-credential-manager configure
    git-credential-manager diagnose
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
