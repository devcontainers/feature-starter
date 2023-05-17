#!/bin/bash

set -e

# Import test library for `check` command
source dev-container-features-test-lib

BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
eval "$("$BREW_PREFIX/bin/brew" shellenv)"

# Check to make sure the user is vscode
check "user is vscode" whoami | grep vscode

# Extension-specific tests
check "mkcert" brew list --formula mkcert

# Report result
reportResults
