#!/bin/bash

set -e

# Import test library for `check` command
source dev-container-features-test-lib

# Check to make sure the user is vscode
check "user is vscode" whoami | grep vscode

# Extension-specific tests
check "mkcert installed" bash -i -c "brew list --formula mkcert"
check "mkcert --version" bash -i -c "mkcert --version"

# Report result
reportResults
