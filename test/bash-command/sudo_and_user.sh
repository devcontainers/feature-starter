#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


check "echo \$HELLO" [ "$(source /etc/environment && echo "$HELLO")" == "5" ]
check "echo \$CURRENT_USER" [ "$(sudo -u vscode -i -- 'source $HOME/.bashrc && echo $CURRENT_USER')" == "vscode" ]


reportResults
