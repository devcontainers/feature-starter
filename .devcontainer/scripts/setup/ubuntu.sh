#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016,SC2143
# init
  set -e
  IS_WSL=${IS_WSL:=false}
  updaterc() {
    line="$1"
    eval "$line"
    echo "Updating ~/.bashrc and ~/.zshrc..."
    rcs=("$HOME/.bashrc" "$HOME/.zshrc")
    for rc in "${rcs[@]}"; do
      if [[ "$(cat "$rc")" != *"$line"* ]]; then
        echo -e "$line" >> "$rc"
      fi
    done
  }
# Get current user
  CURRENT_USER="$(whoami)"
# Update max open files
  sudo sh -c "ulimit -n 1048576"
    line="$CURRENT_USER soft nofile 4096"
    file=/etc/security/limits.conf
    sudo grep -qxF "$line" "$file" || echo "$line" | sudo tee --append "$file"
    line="$CURRENT_USER hard nofile 1048576"
    sudo grep -qxF "$line" "$file" || echo "$line" | sudo tee --append "$file"
# Install apt-packages
  sudo apt update
  sudo apt install -y --fix-broken --fix-missing
  sudo apt upgrade -y
  packages="sudo,systemd,mawk,gawk,bash,zsh,file,sed,curl,wget,grep,bzip2,fonts-dejavu-core,gcc,g++,git,less,locales,openssl,openssh-client,make,cmake,netbase,patch,tzdata,uuid-runtime,apt-transport-https,ca-certificates,speedtest-cli,checkinstall,dos2unix,shellcheck,procps,software-properties-common,libnss3,libnss3-tools,build-essential,zlib1g-dev,bash-completion,age,powerline,fonts-powerline,jq,moreutils,aspnetcore-runtime-6.0,gedit,gimp,nautilus,vlc,x11-apps"
  sudo PACKAGES="$packages" UPDATEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id rocker-org/devcontainer-features apt-packages install
  # Test
    age --version
    age-keygen --version
    zsh --version
# Setup ohmyzsh
  sudo chsh "$(whoami)" -s "$(which zsh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  # powerlevel10k not working in wsl
  # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
  #   rcFile="$HOME/.zshrc"
  #   rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
  #   grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup environment
  updaterc 'source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment'
# Setup Homebrew
  updaterc 'export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"'
  updaterc 'export PATH="$HOMEBREW_PREFIX/bin:$PATH"'
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  updaterc 'eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"'
  # Test
    brew --version
  # Repair and Update if needed
    brew tap --repair
    brew update
  # Install Homebrew packages
  # procps is linux only
    HOMEBREW_ACCEPT_EULA=Y brew install procps
  # These work on all brew platforms
    HOMEBREW_ACCEPT_EULA=Y brew install sevenzip p7zip awk bash zsh oh-my-posh file-formula gnu-sed coreutils grep curl wget bzip2 less buf protobuf grpc asdf
    HOMEBREW_ACCEPT_EULA=Y brew install git git-lfs sigstore/tap/gitsign gh sqlite sqlite-utils gcc llvm openssl@1.1 openssl@3 nghttp2 openssh make cmake cmake-docs
    HOMEBREW_ACCEPT_EULA=Y brew install mkcert go python@3.11 ca-certificates speedtest-cli dos2unix shellcheck nss mono-libgdiplus zlib zlib-ng age jq moreutils
    HOMEBREW_ACCEPT_EULA=Y brew install chezmoi postgresql@15 azure-cli awscli microsoft/mssql-release/msodbcsql18 microsoft/mssql-release/mssql-tools18 gedit
    updaterc 'alias sed=gsed'
    git lfs install
    git lfs install --system
    brew update
    brew upgrade
  # Setup post hombrew packages
    brew link --force --overwrite postgresql@15
    updaterc 'source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh'
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
  updaterc 'export NVM_SYMLINK_CURRENT="true"'
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  updaterc 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
  updaterc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
  # Test
    nvm version
  # Install Node.js latest and lts
    nodes=('node' '--lts')
    for node in "${nodes[@]}"; do
      nvm install "$node"
      # Update npm
        nvm use "$node"
        node --version
        npm update -g npm
        npm --version
        npm version
      # Update npm packages
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
    done
    nvm use node
# Setup dotnet
  updaterc 'export DOTNET_ROLL_FORWARD=LatestMajor'
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
  source "$HOME/.bashrc"
  source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
    rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"'
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"'
    rcFile="$HOME/.zshrc"
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
    updaterc 'PATH="$HOME/.dotnet/tools:$PATH"'
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
# Install docker completions
  rm -rf /etc/bash_completion.d/docker.sh || true
  mkdir -p /etc/bash_completion.d
  touch /etc/bash_completion.d/docker.sh
  curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
  rm -rf /usr/share/zsh/vendor-completions/_docker || true
  mkdir -p /usr/share/zsh/vendor-completions
  touch /usr/share/zsh/vendor-completions/_docker
  curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/docker -o /usr/share/zsh/vendor-completions/_docker
  # Test
    docker --version
    docker-compose --version
# Adding GH .ssh known hosts
  mkdir -p "$HOME/.ssh/"
  touch "$HOME/.ssh/known_hosts"
  bash -c eval "$(ssh-keyscan github.com >> "$HOME/.ssh/known_hosts")"
# Make trusted root CA then install and trust it
  mkcert -install
  dotnet dev-certs https --trust
# Run post-build commands
  sudo -i bash -l -c "\"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup/devspace post-build-sudo"
  bash -l -c "\"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup/devspace post-build-user"
# Continue with devspace setup
  bash -l -c "\"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup devspace"
# Refresh environment
  source "$HOME/.zshrc"
  source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
# Log into GitHub
  if [ "$IS_WSL" != "true" ]; then
    if ! gh auth status; then gh auth login; fi
    gh config set -h github.com git_protocol https
    gh auth status
    # Setup git credential manager
      git-credential-manager configure
      git-credential-manager diagnose
  fi
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
