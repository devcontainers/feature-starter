#!/bin/bash
set -e

source dev-container-features-test-lib

SETTINGS_FILE="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/settings.json"

check "settings.json exists" test -f "$SETTINGS_FILE"
check "hooks key present" grep -q '"hooks"' "$SETTINGS_FILE"
check "statusLine not present" bash -c "! grep -q 'statusLine' '$SETTINGS_FILE'"

reportResults
