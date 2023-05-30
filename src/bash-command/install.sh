#!/usr/bin/env bash
#shellcheck disable=SC2086
set -ex

SUDOCOMMAND="${SUDOCOMMAND:-""}"
USERCOMMAND="${USERCOMMAND:-""}"
USERNAME="${USERNAME:-"automatic"}"

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
    USERNAME=root
  fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} >/dev/null 2>&1; then
  USERNAME=root
fi

# Clean up
rm -rf /var/lib/apt/lists/*

file=/tmp/sudocommand.sh
if [ -n "$SUDOCOMMAND" ]; then
  echo "Running command as root: ${SUDOCOMMAND}"
  echo "$SUDOCOMMAND" > $file
  chmod +x $file
  source $file
  rm -rf $file
fi

file=/tmp/usercommand.sh
if [ -n "$USERCOMMAND" ]; then
  echo "Running command as ${USERNAME}: ${USERCOMMAND}"
  echo "$SUDOCOMMAND" > $file
  chmod +x $file
  sudo chown "$USERNAME":$USERNAME" $file
  su "$USERNAME" -c "bash -l -c $file"
  sudo rm -rf $file
fi

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"
