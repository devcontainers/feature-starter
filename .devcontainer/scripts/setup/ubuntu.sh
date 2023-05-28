#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
set -e
IS_WSL=${IS_WSL:=false}
# Get current user
  CURRENT_USER="$(whoami)"
# Update max open files
  sudo sh -c "ulimit -n 1048576"
    rcLine="$CURRENT_USER soft nofile 4096"
    rcFile=/etc/security/limits.conf
    sudo grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | sudo tee --append "$rcFile"
    rcLine="$CURRENT_USER hard nofile 1048576"
    sudo grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" | sudo tee --append "$rcFile"
# Install apt-packages
  sudo apt update
  sudo apt install -y --fix-broken --fix-missing
  sudo apt upgrade -y
  packages="sudo,systemd,mawk,gawk,bash,zsh,file,sed,curl,wget,grep,bzip2,fonts-dejavu-core,gcc,g++,git,less,locales,openssl,openssh-client,make,cmake,netbase,patch,tzdata,uuid-runtime,apt-transport-https,ca-certificates,speedtest-cli,checkinstall,dos2unix,shellcheck,procps,software-properties-common,libnss3,libnss3-tools,build-essential,zlib1g-dev,bash-completion,age,powerline,fonts-powerline,jq,moreutils,gedit,gimp,nautilus,vlc,x11-apps"
  sudo PACKAGES="$packages" UPDATEPACKAGES="true" "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" -id rocker-org/devcontainer-features apt-packages install
  # Test
    age --version
    age-keygen --version
    zsh --version
# Setup ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
    rcFile="$HOME/.zshrc"
    rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup environment
  source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
    rcLine="source \"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run\" setup environment"
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup Homebrew
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    rcLine='export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"'
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  export PATH="$HOMEBREW_PREFIX/bin:$PATH"
    rcLine='PATH="$HOMEBREW_PREFIX/bin:$PATH"'
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
    rcLine='eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"'
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Test
    brew --version
  # Repair and Update if needed
    brew tap --repair
    brew update
  # Install Homebrew packages
  # procps os linux only
    HOMEBREW_ACCEPT_EULA=Y brew install procps
  # These work on all brew platforms
    HOMEBREW_ACCEPT_EULA=Y brew install sevenzip p7zip awk bash zsh powershell/tap/powershell powershell/tap/powershell-preview oh-my-posh file-formula gnu-sed coreutils curl wget grep bzip2 git git-lfs sigstore/tap/gitsign gh less sqlite sqlite-utils buf protobuf grpc gcc llvm openssl@1.1 openssl@3 nghttp2 openssh make cmake go python@3.11 ca-certificates speedtest-cli dos2unix shellcheck nss mono-libgdiplus zlib zlib-ng age jq moreutils gedit asdf mkcert chezmoi postgresql@15 azure-cli awscli microsoft/mssql-release/msodbcsql18 microsoft/mssql-release/mssql-tools18
    alias sed=gsed
      sed -i 's/^alias sed=.*$/alias sed=gsed/' "$HOME/.bashrc"
      sed -i 's/^alias sed=.*$/alias sed=gsed/' "$HOME/.zshrc"
    brew update
    brew upgrade
  # Setup post hombrew packages
    brew link --force --overwrite postgresql@15
    source /usr/local/opt/asdf/libexec/asdf.sh
      rcLine='source /usr/local/opt/asdf/libexec/asdf.sh'
      rcFile="$HOME/.bashrc"
      grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
      rcFile="$HOME/.zshrc"
      grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Run Homebrew doctor to check for errors
    brew cleanup
    brew doctor
  # Test
    bash --version
    zsh --version
    pwsh --version
    mkcert --version
    chezmoi --version
    gitsign-credential-cache --version
    psql --version
    asdf --version
# Setup nvm
  export NVM_SYMLINK_CURRENT="true"
    rcLine='export NVM_SYMLINK_CURRENT="true"'
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  export NVM_DIR="$NVM_DIR"
    rcLine='export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    rcLine='[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
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
    rcFile="$HOME/.bashrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    rcFile="$HOME/.zshrc"
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Test
    dotnet --version
    dotnet --info
  # Setup dotnet tools
    PATH="$HOME/.dotnet/tools:$PATH"
    rcLine='PATH="$HOME/.dotnet/tools:$PATH"'
    grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
    tool=git-credential-manager
    if [ -z "$(dotnet tool list -g | grep -q "$tool")" ]; then dotnet tool update -g "$tool"; else dotnet tool install -g "$tool"; fi
    # Test
      git-credential-manager --version
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
echo "WARNING: Please restart shell to get latest environment variables"
