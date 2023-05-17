#!/bin/bash

set -e

# Add Homebrew to PATH
BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
eval "$("$BREW_PREFIX/bin/brew" shellenv)"
# Add psql to PATH
PATH="$PATH:/home/linuxbrew/.linuxbrew/opt/libpq/bin"

# Import test library for `check` command
source dev-container-features-test-lib

# Check to make sure the user is vscode
check "user is vscode" whoami | grep vscode

# Extension-specific tests
check "libpq installed" brew list --formula libpq
check "psql --version" psql --version

# Report result
reportResults
