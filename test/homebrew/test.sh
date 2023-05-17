#!/usr/bin/env bash
#shellcheck source=/dev/null
#example=https://github.com/devcontainers/features/blob/main/test/azure-cli/test.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/blob/main/test/homebrew/test.sh
set -e

source /etc/os-release

mustroot='Script must be run as root user.'
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$mustroot"
    exit 1
fi

cleanup() {
  case "${ID}" in
    debian|ubuntu)
      sudo rm -rf /var/lib/apt/lists/*
    ;;
  esac
}

# Clean up
cleanup

check_packages git

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
echo "Testing homebrew..."
check "brew --version"

# Report result
reportResults
