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
echo -e $DEVCONTAINER_FEATURES_PROJECT_ROOT
DEVCONTAINER_POST_BUILD_SUDO_COMMAND="$("$DEVCONTAINER_SCRIPTS_ROOT/utils/echo-sh-as-one-liner.sh" setup/devspace/post-build-sudo)"
export DEVCONTAINER_POST_BUILD_SUDO_COMMAND="$DEVCONTAINER_POST_BUILD_SUDO_COMMAND"
DEVCONTAINER_POST_BUILD_USER_COMMAND="$("$DEVCONTAINER_SCRIPTS_ROOT/utils/echo-sh-as-one-liner.sh" setup/devspace/post-build-user)"
export DEVCONTAINER_POST_BUILD_USER_COMMAND="$DEVCONTAINER_POST_BUILD_USER_COMMAND"
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/gui-sound.sh"
export DISPLAY=${DISPLAY:=host.docker.internal:0}
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:=wayland-0}
mkdir -p /tmp/.X11-unix
export X11=${X11:=/tmp/.X11-unix}
mkdir -p /tmp/runtime-$USER
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:=/tmp/runtime-$USER}
mkdir -p /tmp/pulse/native
export PULSE_SERVER=${PULSE_SERVER:=/tmp/pulse/native}
if [ -e "/mnt/wslg" ]; then
    WSLG=${WSLG:/mnt/wslg}
else
    mkdir -p /tmp/wslg
    WSLG=${WSLG:/tmp/wslg}
fi

export WSLG="$WSLG"
if [ -e "/usr/lib/wsl" ]; then
    LIB_WSL=${LIB_WSL:/usr/lib/wsl}
else
    mkdir -p /tmp/lib/wsl
    LIB_WSL=${LIB_WSL:/tmp/lib/wsl}
fi

export LIB_WSL="$LIB_WSL"
