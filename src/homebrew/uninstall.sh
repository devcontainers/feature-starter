#!/usr/bin/env bash
mustroot='Script must be run as root user.'
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$mustroot"
    exit 1
fi

BREW_PREFIX="${BREW_PREFIX:-"/home/linuxbrew/.linuxbrew"}"
rm -rf "$BREW_PREFIX"
