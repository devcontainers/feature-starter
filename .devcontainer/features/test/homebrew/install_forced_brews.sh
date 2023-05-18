#!/bin/bash
#shellcheck source=/dev/null
set -e

source /etc/os-release

# Import test library for `check` command
echo "Installing test library..."
source dev-container-features-test-lib

# Extension-specific tests
check "libpq installed" brew list --formula libpq
check "psql --version" psql --version

# Report result
echo "All tests passed!"
reportResults
