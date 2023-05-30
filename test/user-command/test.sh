#!/usr/bin/env bash
#shellcheck source=/dev/null

set -e

source dev-container-features-test-lib

user="$(whoami)"
check "$user" [ "$CURRENT_USER" == "$user" ]
if [ "$USERNAME" = "root" ]; then
  COMMAND="${COMMAND:-echo TEST="test" >> /etc/environment}"
  bash -c "$COMMAND"
else
  COMMAND="${COMMAND:-echo TEST="test" >> "$HOME/.bashrc"}"
  su "$USERNAME" -c "$COMMAND"
fi


reportResults
