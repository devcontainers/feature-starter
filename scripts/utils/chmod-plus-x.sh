#!/usr/bin/env zsh
#shellcheck shell=bash
git add "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
git update-index --chmod=+x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" || true
git update-index --chmod=+x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/rund" || true
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" || true
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/rund" || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec git update-index --chmod=+x "{}" \; || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec chmod +x "{}" \; || true
git add "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
