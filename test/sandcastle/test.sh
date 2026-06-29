#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
# Provides the 'check' and 'reportResults' functions.
source dev-container-features-test-lib

check "sandcastle installed" command -v sandcastle && sandcastle --version
check "npm available" command -v npm

reportResults
