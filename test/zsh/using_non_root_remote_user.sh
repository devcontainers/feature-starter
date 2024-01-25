#!/usr/bin/env bash
set -e

source dev-container-features-test-lib
source test_functions.sh

check "default shell should be zsh" assert_default_shell_is_zsh

reportResults
