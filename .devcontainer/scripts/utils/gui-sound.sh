#!/usr/bin/env bash
export DISPLAY=${DISPLAY:-host.docker.internal:0}
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-}
export X11=${X11:-/tmp/.X11-unix}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/tmp/runtime-$USER}
export PULSE_SERVER=${PULSE_SERVER:-/tmp/pulse/native}
