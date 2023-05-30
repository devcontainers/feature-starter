#!/usr/bin/env bash
scriptPath="$1"
script="$2"

cat "$DEVCONTAINER_SCRIPTS_ROOT/$scriptPath/$script.sh"
