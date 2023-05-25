#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


check "echo \$CURRENT_USER" [ "$(sudo -u vscode -i -- bash -l -c 'source $HOME/.bashrc && echo $CURRENT_USER')" == "vscode" ]


reportResults
