#!/bin/sh
set -e

echo "Activating feature 'wokwi'"

# Install Wokwi CLI
curl -L https://wokwi.com/ci/install.sh | sh

echo "Wokwi CLI installed"