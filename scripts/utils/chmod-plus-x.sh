#!/usr/bin/env zsh
#shellcheck shell=bash
set -e
git update-index --add --chmod=+x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/scripts" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec chmod +x "{}" \;
