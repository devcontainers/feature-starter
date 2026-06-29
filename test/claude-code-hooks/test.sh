#!/bin/bash
set -e

source dev-container-features-test-lib

SETTINGS_FILE="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/settings.json"
HOOKS_DIR="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/hooks"

check "settings.json exists" test -f "$SETTINGS_FILE"
check "hooks directory exists" test -d "$HOOKS_DIR"
check "lib directory exists" test -d "$HOOKS_DIR/lib"
check "session hooks exist" test -f "$HOOKS_DIR/session/start.sh"
check "agent hooks exist" test -f "$HOOKS_DIR/agent/pretooluse.sh"
check "turn hooks exist" test -f "$HOOKS_DIR/turn/userpromptsubmit.sh"
check "settings has hooks key" grep -q '"hooks"' "$SETTINGS_FILE"

reportResults
