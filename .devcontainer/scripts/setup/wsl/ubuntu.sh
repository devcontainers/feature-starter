#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
#shellcheck disable=SC2016
dotnet_latest_major_global=$(cat <<-EOF
{
  "sdk": {
    "rollForward": "latestmajor"
  }
}
EOF
)
# init
  set -e
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
# Run base ubuntu setup
  IS_WSL=true source "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup ubuntu
  # TODO: Homebrew fix, why?
    updaterc 'export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"'
    updaterc 'export PATH="$HOMEBREW_PREFIX/bin:$PATH"'
    updaterc 'eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"'
  # TODO: dotnet tools fix, why?
    echo "$dotnet_latest_major_global" > "$HOME/global.json"
    updaterc 'PATH="$HOME/.dotnet/tools:$PATH"'
# Install WSL Utilties
  # https://github.com/wslutilities/wslu
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y wslu
# Setup windows browser as default
  alias xdg-open=wslview
    rcSed='s/^alias xdg-open=.*$/alias xdg-open=wslview/'
    sed -i "$rcSed" "$HOME/.bashrc"
    sed -i "$rcSed" "$HOME/.zshrc"
  export BROWSER=wslview
    rcSed='s/^export BROWSER=.*$/export BROWSER=wslview/'
    sed -i "$rcSed" "$HOME/.bashrc"
    sed -i "$rcSed" "$HOME/.zshrc"
# Log into GitHub
  if ! gh auth status; then gh auth login; fi
  gh config set -h github.com git_protocol https
  gh auth status
  # Setup git credential manager
    git-credential-manager configure
    git-credential-manager diagnose
# WSLg GPU acceleration
  # glxinfo
# Done
  echo "WARNING: Please restart shell to get latest environment variables"
