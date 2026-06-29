#!/bin/bash

set -e

source dev-container-features-test-lib

SETTINGS_FILE="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/settings.json"

check "settings.json exists" test -f "$SETTINGS_FILE"
check "ollama baseUrl set" grep -q "http://ollama:11434" "$SETTINGS_FILE"
check "telemetry disabled" grep -q '"DISABLE_TELEMETRY": "1"' "$SETTINGS_FILE"
check "cleanupPeriodDays set" grep -q '"cleanupPeriodDays": 14' "$SETTINGS_FILE"

reportResults
