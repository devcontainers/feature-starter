#!/usr/bin/env bash
#shellcheck disable=SC2068
set -e
updaterc() {
  set -e
  echo "Updating $HOME/.bashrc and $HOME/.zshrc..."
  if [[ "$(cat "$HOME/.bashrc")" != *"$1"* ]]; then
      echo -e "$1" >> "$HOME/.bashrc"
  fi
  if [ -f "$HOME/.zshrc" ] && [[ "$(cat "$HOME/.zshrc")" != *"$1"* ]]; then
      echo -e "$1" >> "$HOME/.zshrc"
  fi
}


export PATH="/usr/local/dotnet/current:$PATH"
declare -a DOTNET_TOOLS=("${TOOLS//,/ }")
if [ -n "$TOOLS" ]; then
    echo "Installing $TOOLS..."
    for i in ${DOTNET_TOOLS[@]}; do if dotnet tool list -g "$i"; then dotnet tool update -g "$i"; else echo "Installing $i"; dotnet tool install -g "$i"; fi; done
fi

updaterc "export DOTNET_HOME=/usr/local/dotnet"
updaterc "export PATH=\"/usr/local/dotnet/current:\${PATH}\""
updaterc "export PATH=\"$HOME/.dotnet/tools:\$PATH\""
