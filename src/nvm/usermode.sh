#!/usr/bin/env bash
#shellcheck source=/dev/null
#shellcheck disable=SC2068
declare -a NPM_PACKAGES=("${PACKAGES//,/ }")
set -e
umask 0002
# Create a symlink to the installed version for use in Dockerfile PATH statements
export NVM_SYMLINK_CURRENT="true"
curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash 
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
nvm version
# Install Node.js
nvm install --lts
nvm install node
# Update lts npm
nvm use --lts
node --version
npm update -g npm
npm --version
npm version
# Update lts npm packages
npm i -g npm-check-updates && ncu -u && npm i
# Install global packages on lts
if [ -n "$PACKAGES" ]; then
    echo "Installing $PACKAGES in lts..."
    for i in ${NPM_PACKAGES[@]}; do echo "Installing $i"; npm i -g "$i"; done
fi
# Update latest npm
nvm use node
node --version
npm update -g npm
npm --version
npm version
# Update latest npm packages
npm i -g npm-check-updates && ncu -u && npm i
# Install global packages on latest
if [ -n "$PACKAGES" ]; then
    echo "Installing $PACKAGES in latest..."
    for i in ${NPM_PACKAGES[@]}; do echo "Installing $i"; npm i -g "$i"; done
fi
