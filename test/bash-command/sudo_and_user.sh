#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


check "echo \$HELLO" [ "$(source /etc/environment && echo "$HELLO")" == "5" ]
check "echo \$CURRENT_USER" [ "bash", "-l", "-c", "su \"vscode\" -c $(source ~/.bashrc && echo "$CURRENT_USER")" == "$(whoami)" ]


reportResults
