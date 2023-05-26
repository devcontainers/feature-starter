#!/usr/bin/env bash

# Update submodules
pushd "$DEVCONTAINER_FEATURES_PROJECT_ROOT" || exit
git submodule sync --recursive || true
git submodule update --init --recursive || true
git submodule foreach --recursive git checkout main || true
git submodule foreach --recursive git pull || true
popd || exit

