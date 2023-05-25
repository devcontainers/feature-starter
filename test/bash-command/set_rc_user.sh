#!/usr/bin/env bash
#shellcheck disable=SC2016
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

user="$(whoami)"
source "$HOME/.bashrc"
check "echo $CURRENT_USER" [ "echo $CURRENT_USER" == "$user" ]

reportResults
