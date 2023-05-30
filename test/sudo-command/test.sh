#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


check "echo \$TEST" [ "$(source /etc/environment && echo "$TEST")" == "test" ]


reportResults
