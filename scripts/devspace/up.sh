#!/usr/bin/env zsh
#shellcheck shell=bash
set -e
devcontainer up --workspace-folder "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
