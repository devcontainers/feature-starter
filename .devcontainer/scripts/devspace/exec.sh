#!/usr/bin/env bash
#shellcheck shell=bash
set -e
commandPath="$1"
command="$2"
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" devspace up
containerid=$(docker ps -q -f name="$DEVCONTAINER_PROJECT_NAME-devspace")
devcontainer exec --container-id "$containerid" zsh -l -c "\$DEVCONTAINER_FEATURES_PROJECT_ROOT/run $commandPath $command"
