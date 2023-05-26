#!/usr/bin/env bash
#shellcheck shell=bash
#shellcheck source=/dev/null
set -e
projectRoot="$(dirname "$(dirname "$(dirname "$(cd -- "$(dirname -- "${BASH_SOURCE-$0}")" &> /dev/null && pwd)")")")"
set -o allexport
source "$projectRoot/.devcontainer/.env"
set +o allexport
export PSHELL="pwsh"
export DEVCONTAINER_FEATURES_PROJECT_ROOT="$projectRoot"
export DEVCONTAINER_FEATURES_SOURCE_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/src"
export DEVCONTAINER_SCRIPTS_ROOT="$DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts"
DEVCONTAINER_POST_BUILD_SUDO_COMMAND="$("$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" utils echo-sh-as-one-liner "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-sudo")"
export DEVCONTAINER_POST_BUILD_SUDO_COMMAND="$DEVCONTAINER_POST_BUILD_SUDO_COMMAND"
DEVCONTAINER_POST_BUILD_USER_COMMAND="$("$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" utils echo-sh-as-one-liner "$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace/post-build-user")"
export DEVCONTAINER_POST_BUILD_USER_COMMAND="$DEVCONTAINER_POST_BUILD_USER_COMMAND"
