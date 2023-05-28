#!/usr/bin/env bash

# Update submodules
pushd "$DEVCONTAINER_FEATURES_PROJECT_ROOT" || exit
if ! git submodule foreach --recursive git pull; then
  git submodule sync --recursive
  git submodule update --init --recursive
  git submodule foreach --recursive git checkout main
fi

git submodule foreach --recursive git pull
popd || exit
