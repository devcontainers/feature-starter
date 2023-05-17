#!/usr/bin/env bash
#shellcheck source=/dev/null
set -e

source /etc/os-release

if [ "$(id -u)" -eq 0 ]; then
  echo -e 'Script must not be run as root.'
  exit 1
fi

NON_ROOT_USER=""
POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
  if id -u "${CURRENT_USER}" >/dev/null 2>&1; then
    NON_ROOT_USER=${CURRENT_USER}
    break
  fi
done
if [ "${NON_ROOT_USER}" = "" ]; then
  echo -e 'Script must not be run as root.'
  exit 1
fi

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
echo "Testing with user: ${NON_ROOT_USER}"
check "homebrew" su "${NON_ROOT_USER}" -c 'brew --version'

# Report result
reportResults
