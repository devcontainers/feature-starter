#!/usr/bin/env bash
notroot='Script must be run as non-root user.'
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$notroot"
    exit 1
fi

BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
rm -rf "$BREW_PREFIX"
