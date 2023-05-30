#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


if [ "$USERNAME" = "root" ]; then
    check "echo \$TEST" [ "$(source /etc/environment && echo "$TEST")" == "test" ]
else
    check "echo \$TEST" [ "$(source "$HOME/.bashrc" && echo "$TEST")" == "test" ]
fi


reportResults
