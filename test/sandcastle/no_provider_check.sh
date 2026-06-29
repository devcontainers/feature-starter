#!/bin/bash
set -e

source dev-container-features-test-lib

check "sandcastle installed without provider" command -v sandcastle

reportResults
