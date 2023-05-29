#!/bin/bash

# Update submodules
init_submodules="false"
submodule_path="$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/dependencies/devcontainers/features"
if [ -d "$submodule_path" ]; then
  directory_info=$(ls -A "$submodule_path")
  if [ -z "$directory_info" ]; then
    init_submodules="true"
  fi
fi

pushd "$DEVCONTAINER_FEATURES_PROJECT_ROOT" || exit 1
if [ "$init_submodules" = "true" ]; then
  git submodule sync --recursive
  git submodule update --init --recursive
  git submodule foreach --recursive git checkout main
fi

git submodule foreach --recursive git pull
popd || exit
