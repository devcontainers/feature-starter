#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

who="$(whoami)"
check "\$TEST=43" [ "$(source "$HOME/.bashrc" && echo "$TEST")" == "43" ]
check "\$TEST_USER=$who" [ "$(source "$HOME/.bashrc" && echo "$TEST_USER")" == "$who" ]

reportResults
