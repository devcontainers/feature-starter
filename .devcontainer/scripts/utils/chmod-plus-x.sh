#!/usr/bin/env bash
#shellcheck shell=bash
set -e
git update-index --add --chmod=+x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
dos2unix "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" || true
git update-index --add --chmod=+x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/init"
chmod +x "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/init"
dos2unix "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/init" || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts" -type f -iname "*.sh" -exec dos2unix "{}" \; || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -type f -iname "*.sh" -exec dos2unix "{}" \; || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -type f -iname "*.sh" -exec git update-index --add --chmod=+x "{}" \;
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -type f -iname "*.sh" -exec dos2unix "{}" \; || true
find "$DEVCONTAINER_FEATURES_PROJECT_ROOT" -type f -iname "*.sh" -exec chmod +x "{}" \;
