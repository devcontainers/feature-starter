#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

who="$(whoami)"
check "\$TEST=42" [ "$(source "$HOME/.bashrc" && echo "$TEST")" == "42" ]
check "\$TEST_USER=$who" [ "$(source "$HOME/.bashrc" && echo $CURRENT_USER)" == "$user" ]

reportResults
