#!/usr/bin/env bash
#shellcheck source=/dev/null
#example=https://github.com/devcontainers/features/blob/main/test/azure-cli/test.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/blob/main/test/homebrew/test.sh
set -e

source /etc/os-release

# Optional: Import test library bundled with the devcontainer CLI
echo "Installing test library..."
source dev-container-features-test-lib

# Feature-specific tests
echo "Testing homebrew..."
check "nvm --version"

# Report result
echo "All tests passed!"
reportResults
