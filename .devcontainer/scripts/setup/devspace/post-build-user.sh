#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  updaterc() { local line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
  HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}
  USERNAME="${USERNAME:-$(whoami)}"
  os=$(uname -s)
# Make Edge the default browser if installed
  browser='/usr/bin/microsoft-edge-stable'
  cmds=("alias xdg-open=$browser" "export BROWSER=$browser")
  seds=("s:^alias xdg-open=.*$:alias xdg-open=$browser:" "s:^export BROWSER=.*$:export BROWSER=$browser:")
  files=("$HOME/.bashrc" "$HOME/.zshrc")
  # shellcheck disable=SC2068
  for i in ${!cmds[@]}; do
    cmd="${cmds[$i]}"
    sed="${seds[$i]}"
    eval "$cmd"
    for file in "${files[@]}"; do
      sed -i "$sed" "$file"
      grep -qF "$cmd" "$file" || echo "$cmd" >> "$file"
    done
  done
# Setup ohmyzsh and make zsh default shell
  sudo chsh "$USERNAME" -s "$(which zsh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  # powerlevel10k not working in wsl
  # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" || true
  #   rcFile="$HOME/.zshrc"
  #   rcLine='source ~/powerlevel10k/powerlevel10k.zsh-theme'
  #   grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Setup Homebrew
  sudo echo "sudo cached for noninteractive homebrew install"
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  cat "$HOME/.bashrc"
  updaterc "eval \"\$("$HOMEBREW_PREFIX/bin/brew" shellenv)\""
  # Install taps
    brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
  # Repair and Update if needed
    brew update
    brew tap --repair
  # Install Homebrew packages
    # procps is linux only
      if [ "$os" == "Linux" ]; then HOMEBREW_ACCEPT_EULA=Y brew install procps; fi
    # These work on all brew platforms
      HOMEBREW_ACCEPT_EULA=Y brew install sevenzip p7zip awk bash zsh oh-my-posh file-formula gnu-sed coreutils grep curl wget bzip2 less zlib zlib-ng dotnet dotnet@6
      HOMEBREW_ACCEPT_EULA=Y brew install buf protobuf grpc dos2unix git git-lfs sigstore/tap/gitsign-credential-cache sigstore/tap/gitsign gh asdf jq moreutils
      HOMEBREW_ACCEPT_EULA=Y brew install gcc llvm age nss openssl@1.1 openssl@3 nghttp2 openssh make cmake cmake-docs mkcert go python@3.11 ca-certificates shellcheck
      HOMEBREW_ACCEPT_EULA=Y brew install speedtest-cli mono-libgdiplus chezmoi sqlite sqlite-utils postgresql@15 azure-cli awscli msodbcsql18 mssql-tools18 gedit
      updaterc 'alias sed=gsed'
  # Upgrade all packages
    brew update
    brew upgrade
  # Setup post hombrew packages
    brew link --force --overwrite postgresql@15
    updaterc "source \"$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh\""
  # Run Homebrew cleanup and doctor to check for errors
    brew cleanup
    brew doctor
# Setup nvm
  updaterc 'export NVM_SYMLINK_CURRENT="true"'
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  # shellcheck disable=SC2016
  updaterc 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
  # shellcheck disable=SC2016
  updaterc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
  # Create default package.json
  default_package_json="{ "name": "devspace" }"
  echo "$default_package_json" > package.json
  # Install Node.js latest and lts
    nodes=('node' '--lts')
    packages=('@npmcli/fs' '@devcontainers/cli' 'dotenv-cli' 'typescript' 'npm-check-updates')
    for node in "${nodes[@]}"; do nvm install "$node"; nvm use "$node"; node --version; npm update -g npm; npm i -g "${packages[@]}"; ncu -u; done
    nvm use node
# Setup dotnet
  dotnet_latest_major_global='{ "sdk": { "rollForward": "latestmajor" } }'
  updaterc 'export DOTNET_ROLL_FORWARD=LatestMajor'
  echo "$dotnet_latest_major_global" > "$HOME/global.json"
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
  # Update rc files
    updaterc "export DOTNET_ROOT=\"\$HOME/.asdf/installs/dotnet-core/$preview\""
    # shellcheck source=/dev/null
    source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
      # shellcheck disable=SC2016
      rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.bash"'
      rcFile="$HOME/.bashrc"
      grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
      # shellcheck disable=SC2016
      rcLine='source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"'
      rcFile="$HOME/.zshrc"
      grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
  # Setup dotnet workloads
    dotnet workload install --include-previews wasi-experimental
    # Clean, repair, and update
      dotnet workload clean
      dotnet workload update
      dotnet workload repair
  # Setup dotnet tools
    tools=('powershell' 'git-credential-manager')
    for tool in "${tools[@]}"; do if [ -z "$(dotnet tool list -g | grep -q "$tool")" ]; then dotnet tool update -g "$tool"; else dotnet tool install -g "$tool"; fi; done
      # shellcheck disable=SC2016
    updaterc 'PATH="$HOME/.dotnet/tools:$PATH"'
    echo "$dotnet_latest_major_global" > "$HOME/.dotnet/tools/global.json"
# Setup pwsh modules
  pwsh_modules=('Pester' 'Set-PsEnv')
  pwsh_update='Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber; Update-Module; Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber -AllowPrerelease; Set-Alias -Name awk -Value gawk'
  # shellcheck disable=SC2016
  pwsh_install_module='Install-Module -Name $module -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber;'
  # shellcheck disable=SC2034
  install_modules() { local pwsh=$1; "$pwsh" -Command "$pwsh_update"; for module in "${pwsh_modules[@]}"; do $pwsh -Command "$(eval echo "$pwsh_install_module")"; done }
  # PowerShell Core (pwsh)
    if command -v pwsh > /dev/null; then install_modules "pwsh"; else echo "PowerShell Core is not installed"; fi
  # PowerShell Core Preview (pwsh-preview)
    if command -v pwsh-preview > /dev/null; then install_modules "pwsh-preview"; else echo "PowerShell Core Preview is not installed"; fi
# Make trusted root CA then install and trust it
  mkcert -install
  dotnet dev-certs https --trust
# Adding GH .ssh known hosts
  mkdir -p "$HOME/.ssh/"
  touch "$HOME/.ssh/known_hosts"
  bash -c eval "$(ssh-keyscan github.com >> "$HOME/.ssh/known_hosts")"
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
