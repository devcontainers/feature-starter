#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

echo -e "$(whoami)"
check "echo \$CURRENT_USER" [ "$(source "$HOME/.bashrc" && echo "$CURRENT_USER")" == "$(whoami)" ]


reportResults
