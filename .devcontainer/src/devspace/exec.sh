#!/usr/bin/env zsh
#shellcheck shell=bash
command="$1"
"$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/src/up.sh"
containerid=$(docker ps -q -f name="$DEVCONTAINER_PROJECT_NAME-devspace")
devcontainer exec --container-id "$containerid" zsh -l -c "$DEVCONTAINER_FEATURES_PROJECT_ROOT/$command"
