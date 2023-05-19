#!/usr/bin/env bash
nvm version
# Install Node.js
nvm install --lts
nvm install node
nvm use --lts
node --version
# Update lts npm
npm update -g npm
npm --version
npm version
# Update lts npm packages
npm i -g npm-check-updates && ncu -u && npm i
nvm use node
node --version
# Update latest npm
npm update -g npm
npm --version
npm version
# Update latest npm packages
npm i -g npm-check-updates && ncu -u && npm i
