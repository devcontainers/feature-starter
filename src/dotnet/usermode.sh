#!/bin/bash
set -e
updaterc() {
    if [ "${UPDATE_RC}" = "true" ]; then
        echo "Updating ~/.bashrc and ~/.zshrc..."
        if [[ "$(cat ~/.bashrc)" != *"$1"* ]]; then
            echo -e "$1" >> ~/.bashrc
        fi
        if [ -f "~/.zshrc" ] && [[ "$(cat ~/.zshrc)" != *"$1"* ]]; then
            echo -e "$1" >> ~/.zshrc
        fi
    fi
}

export PATH="/usr/local/dotnet/current:$PATH"
declare -a DOTNET_TOOLS=("${TOOLS//,/ }")
if [ -n "$TOOLS" ]; then
    echo "Installing $TOOLS..."
    for i in ${DOTNET_TOOLS[@]}; do if dotnet tool list -g "$i"; then dotnet tool update -g "$i"; else echo "Installing $i"; dotnet tool install -g "$i"; fi; done
fi

updaterc "export PATH=\"$HOME/.dotnet/tools:\$PATH\""
