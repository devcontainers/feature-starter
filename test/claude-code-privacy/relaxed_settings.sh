#!/bin/bash
set -e

source dev-container-features-test-lib

SETTINGS_FILE="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/settings.json"

check "telemetry enabled" grep -q '"DISABLE_TELEMETRY": "0"' "$SETTINGS_FILE"
check "cleanup set to 7 days" grep -q '"cleanupPeriodDays": 7' "$SETTINGS_FILE"

reportResults
