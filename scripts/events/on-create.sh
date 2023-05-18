#!/usr/bin/env zsh
#shellcheck shell=bash
rm -f nohup.out
rm -f gcm-diagnose.log
"$DEVCONTAINER_SCRIPTS_ROOT/setup/devspace.sh"
echo "Press Ctrl+Shift+~ to open a terminal in the current dev container"
