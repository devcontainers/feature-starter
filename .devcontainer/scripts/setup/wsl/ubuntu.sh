#!/usr/bin/env bash
# init
  # Setup to use windows git credential manager if exists
    gcm="/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe"
    if [ -e "$(eval echo $gcm)" ]; then
      echo "Updating credential helper to use windows"
      git config --global credential.helper "$gcm"
    fi
# Run base ubuntu setup
  # shellcheck source=/dev/null
  export IS_WSL="true"
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/setup/ubuntu.sh"
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Install WSL Utilties
  # https://github.com/wslutilities/wslu
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y --install-recommends wslu
# Setup windows browser as default
  browser=wslview
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
# Log into GitHub
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gh-login.sh"
# WSLg GPU acceleration
  # glxinfo
# Done
  echo "Please restart shell to get latest environment variables"
