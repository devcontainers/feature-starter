#!/usr/bin/env bash
#shellcheck source=/dev/null
#example=https://github.com/devcontainers/features/blob/main/test/azure-cli/test.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/blob/main/test/homebrew/test.sh
set -e

source /etc/os-release

notroot='Script must be run as non-root user.'
cleanup() {
  case "${ID}" in
    debian|ubuntu)
      echo "Cleaning up apt cache..."
      rm -rf /var/lib/apt/lists/*
    ;;
  esac
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install "$@"
    fi
}

# Clean up
cleanup

echo "Installing dependencies..."
check_packages git

# Optional: Import test library bundled with the devcontainer CLI
echo "Installing test library..."
source dev-container-features-test-lib

# Feature-specific tests
echo "Testing homebrew..."
check "brew --version"

# Report result
echo "All tests passed!"
reportResults
# Testing
