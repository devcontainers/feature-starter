#!/bin/bash
set -e

source dev-container-features-test-lib

check "sandcastle installed" command -v sandcastle

reportResults
