#!/usr/bin/env bash
#shellcheck source=/dev/null
#example=https://github.com/devcontainers/features/blob/main/test/azure-cli/test.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/blob/main/test/homebrew/test.sh
set -e

# Import test library for `check` command
echo "Installing test library..."
source dev-container-features-test-lib


# Extension-specific tests
check "dotenv --help" dotenv --help

# Report result
echo "All tests passed!"
reportResults
