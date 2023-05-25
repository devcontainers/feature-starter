#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib


cmd="bash -l -c 'source ~/.bashrc && echo \$CURRENT_USER'"
check "echo \$CURRENT_USER" "[ \"$(su vscode -c "$cmd")\" == \"$(whoami)\" ]"


reportResults
