#!/usr/bin/env bash
#shellcheck disable=SC2086
set -ex

USERNAME="${USERNAME:-"automatic"}"
COMMAND="${COMMAND:-}"
who="$(whoami)"

# Determine the appropriate non-root user.
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
  USERNAME=""
  POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
  for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
    if id -u "${CURRENT_USER}" >/dev/null 2>&1; then
      USERNAME="${CURRENT_USER}"
      break
    fi
  done
  if [ "${USERNAME}" = "" ]; then
    USERNAME="$who"
  fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} >/dev/null 2>&1; then
  USERNAME="$who"
fi

# Clean up
rm -rf /var/lib/apt/lists/*

# Run
su "$USERNAME" -c "$COMMAND"

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"
