#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'wokwi' Feature with no options.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "wokwi-cli installed" which wokwi-cli

# Report results
reportResults