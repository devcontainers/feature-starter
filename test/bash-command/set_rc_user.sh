#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


su "vscode" -c check "echo $CURRENT_USER" [ "bash", "-l", "-c", "$(source ~/.bashrc && echo "$CURRENT_USER")" == "$(whoami))" ]


reportResults
