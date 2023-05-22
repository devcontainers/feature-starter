#!/usr/bin/env bash
#shellcheck source=/dev/null
#example=https://github.com/devcontainers/features/blob/main/test/azure-cli/test.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/blob/main/test/homebrew/test.sh
set -e

# Import test library for `check` command
echo "Installing test library..."
source dev-container-features-test-lib

# Fix for git-credential-manager
export GCM_CREDENTIAL_STORE=cache
sudo rm -rf /usr/share/dotnet || false
sudo ln -s /usr/local/dotnet/6.0.408 /usr/share/dotnet

# Extension-specific tests
check "git-credential-manager --version" git-credential-manager --version

# Report result
echo "All tests passed!"
reportResults
