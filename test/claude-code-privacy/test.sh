#!/bin/bash
set -e

source dev-container-features-test-lib

SETTINGS_FILE="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/settings.json"

check "settings.json exists" test -f "$SETTINGS_FILE"
check "telemetry disabled" grep -q '"DISABLE_TELEMETRY": "1"' "$SETTINGS_FILE"
check "error reporting disabled" grep -q '"DISABLE_ERROR_REPORTING": "1"' "$SETTINGS_FILE"
check "updates disabled" grep -q '"DISABLE_UPDATES": "1"' "$SETTINGS_FILE"
check "cleanupPeriodDays set" grep -q '"cleanupPeriodDays":' "$SETTINGS_FILE"

reportResults
