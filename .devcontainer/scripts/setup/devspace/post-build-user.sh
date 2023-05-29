#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
set -e
# Make Edge the default browser
export BROWSER=/usr/bin/microsoft-edge-beta
rcLine=export BROWSER=/usr/bin/microsoft-edge-beta
rcFile=$HOME/.bashrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
rcFile=$HOME/.zshrc
grep -qxF "$rcLine" "$rcFile" || echo "$rcLine" >> "$rcFile"
# Make trusted root CA then install and trust it
mkcert -install
dotnet dev-certs https --trust
