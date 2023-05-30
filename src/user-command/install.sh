#!/usr/bin/env bash
#shellcheck disable=SC2086
set -ex

USERNAME="$(whoami)"

# Setup command
if [ "$USERNAME" = "root" ]; then
  COMMAND="${COMMAND:-echo TEST="test" >> /etc/environment}"
else
  COMMAND="${COMMAND:-echo TEST="test" >> "$HOME/.bashrc"}"
fi

# Clean up
rm -rf /var/lib/apt/lists/*

# Run
su "$USERNAME" -c "$COMMAND"

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"
