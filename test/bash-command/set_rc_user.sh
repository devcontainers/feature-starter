#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

echo -e "$(whoami)"
echo -e "Sourcing .bashrc..."
source "$HOME/.bashrc"
echo -e "Done sourcing .bashrc"
echo -e "CURRENT_USER is $CURRENT_USER"
check "echo $CURRENT_USER" [ "echo $CURRENT_USER" == "$(whoami)" ]

reportResults
