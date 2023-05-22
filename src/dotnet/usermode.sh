#!/bin/bash
declare -a DOTNET_TOOLS=("${TOOLS//,/ }")
export PATH="$PATH:/usr/local/dotnet/current"
if [ -n "$TOOLS" ]; then
    echo "Installing $TOOLS..."
    for i in ${DOTNET_TOOLS[@]}; do if dotnet tool list -g "$i"; then dotnet tool update -g "$i"; else echo "Installing $i"; dotnet tool install -g "$i"; fi; done
fi
