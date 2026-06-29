#!/bin/bash
set -e

source dev-container-features-test-lib

SETTINGS_FILE="${_REMOTE_USER_HOME:-/home/$(whoami)}/.claude/settings.json"

check "custom baseUrl" grep -q "http://ollama:11434" "$SETTINGS_FILE"
check "custom sonnet model" grep -q "custom-sonnet:latest" "$SETTINGS_FILE"

reportResults
