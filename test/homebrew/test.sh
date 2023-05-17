#!/usr/bin/env bash
#shellcheck source=/dev/null
#example=https://github.com/devcontainers/features/blob/main/test/azure-cli/test.sh
#example=https://github.com/meaningful-ooo/devcontainer-features/blob/main/test/homebrew/test.sh
set -e

source /etc/os-release

cleanup() {
  case "${ID}" in
    debian|ubuntu)
      rm -rf /var/lib/apt/lists/*
    ;;
  esac
}

mostrunasroot='Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$mostrunasroot"
    exit 1
fi

# Clean up
cleanup

NON_ROOT_USER=""
POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
  if id -u ${CURRENT_USER} >/dev/null 2>&1; then
    NON_ROOT_USER=${CURRENT_USER}
    break
  fi
done
if [ "${NON_ROOT_USER}" = "" ]; then
    echo -e "$mostrunasroot"
    exit 1
fi

check_packages git

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
echo "Testing with user: ${NON_ROOT_USER}"
check "homebrew" su "${NON_ROOT_USER}" -c 'brew --version'

# Report result
reportResults
