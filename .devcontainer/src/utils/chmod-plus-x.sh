#!/usr/bin/env zsh
#shellcheck shell=bash
git add "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
git update-index --chmod=+x "run"
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/rund"
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec git update-index --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec chmod +x "{}" \;
