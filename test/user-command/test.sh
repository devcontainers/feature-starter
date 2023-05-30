#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

user="$(whoami)"
check "$CURRENT_USER" [ "$CURRENT_USER" == "$user" ]
if [ "$USERNAME" = "root" ]; then
  COMMAND="${COMMAND:-echo TEST="test" >> /etc/environment}"
  bash -c "$COMMAND"
  check "echo \$TEST" [ "$(source /etc/environment)" ]
else
  COMMAND="${COMMAND:-echo TEST="test" >> "$HOME/.bashrc"}"
  su "$USERNAME" -c "$COMMAND"
  check "echo \$TEST" [ "$(source "$HOME/.bashrc")" ]
fi


reportResults
