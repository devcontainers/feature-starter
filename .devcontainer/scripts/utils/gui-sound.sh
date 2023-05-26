#!/usr/bin/env bash
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    export DISPLAY=host.docker.internal:0
    export XDG_RUNTIME_DIR=${X11:-/tmp}
    export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/tmp}
    export PULSE_SERVER=${PULSE_SERVER:-/tmp/pulse/native}
fi
