#!/bin/bash
#shellcheck source=/dev/null
set -e

# Import test library for `check` command
source dev-container-features-test-lib

# Check to make sure the user is vscode
check "user is vscode" whoami | grep vscode

# Extension-specific tests
check "libpq installed" brew list --formula libpq
check "psql --version" psql --version

# Report result
reportResults
