#!/usr/bin/env bash

# Checks if packages are installed and installs them if not
check_and_install() {
  for package in "$@"; do
    if ! dpkg -s "$package" >/dev/null 2>&1; then
      echo "$package is not installed - starting installation"
      if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
      fi
      apt-get -y install --no-install-recommends "$package"
    fi
  done
}
