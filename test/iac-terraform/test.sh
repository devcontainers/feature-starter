#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "terraform is installed" terraform --version
check "tfswitch is installed" command -v tfswitch

# Report result
reportResults
