#!/usr/bin/env bash
if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root.'
  exit 1
fi

BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
rm -rf "$BREW_PREFIX"
