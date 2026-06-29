#!/bin/bash
set -e

source dev-container-features-test-lib

SETTINGS_FILE="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/settings.json"

check "settings.json exists" test -f "$SETTINGS_FILE"
check "ollama baseUrl set" grep -q "http://localhost:11434" "$SETTINGS_FILE"
check "haiku model set" grep -q "minimax-m2.5:cloud" "$SETTINGS_FILE"
check "sonnet model set" grep -q "kimi-k2.6:cloud" "$SETTINGS_FILE"

reportResults
