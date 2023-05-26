#!/usr/bin/env bash
export DISPLAY=${DISPLAY:=host.docker.internal:0}
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:=wayland-0}
mkdir -p /tmp/.X11-unix
export X11=${X11:=/tmp/.X11-unix}
mkdir -p /tmp/runtime-$USER
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:=/tmp/runtime-$USER}
mkdir -p /tmp/pulse/native
export PULSE_SERVER=${PULSE_SERVER:=/tmp/pulse/native}
if [ -e "/mnt/wslg" ]; then
    WSLG=${WSLG:=/mnt/wslg}
else
    mkdir -p /tmp/wslg
    WSLG=${WSLG:=/tmp/wslg}
fi

export WSLG="$WSLG"
if [ -e "/usr/lib/wsl" ]; then
    LIB_WSL=${LIB_WSL:=/usr/lib/wsl}
else
    mkdir -p /tmp/lib/wsl
    LIB_WSL=${LIB_WSL:=/tmp/lib/wsl}
fi

export LIB_WSL="$LIB_WSL"
