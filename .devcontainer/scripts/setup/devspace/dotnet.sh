#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
  updaterc() { local line="$1"; eval "$line"; echo "Updating ~/.bashrc and ~/.zshrc..."; rcs=("$HOME/.bashrc" "$HOME/.zshrc"); for rc in "${rcs[@]}"; do if [[ "$(cat "$rc")" != *"$line"* ]]; then echo "$line" >> "$rc"; fi; done }
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
