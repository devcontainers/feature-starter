#!/bin/sh
set -e

echo "Activating feature 'claude-code-ollama'"

# Ensure python3 is available
if ! command -v python3 >/dev/null 2>&1; then
    echo "Installing python3..."
    if command -v apt-get >/dev/null 2>&1; then
        apt-get update && apt-get install -y --no-install-recommends python3
        apt-get clean && rm -rf /var/lib/apt/lists/*
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache python3
    elif command -v yum >/dev/null 2>&1; then
        yum install -y python3
    elif command -v dnf >/dev/null 2>&1; then
        dnf install -y python3
    else
        echo "ERROR: python3 is required but could not be installed"
        exit 1
    fi
fi

BASE_URL="${BASEURL:-http://localhost:11434}"
AUTH_TOKEN="${AUTHTOKEN:-ollama}"
HAIKU_MODEL="${HAIKUMODEL:-minimax-m2.5:cloud}"
OPUS_MODEL="${OPUSMODEL:-glm-5.2:cloud}"
SONNET_MODEL="${SONNETMODEL:-kimi-k2.6:cloud}"
SUBAGENT_MODEL="${SUBAGENTMODEL:-kimi-k2.7-code:cloud}"
LOG_LEVEL="${LOGLEVEL:-error}"

USER_HOME="${_REMOTE_USER_HOME:-/home/${_REMOTE_USER:-$(whoami)}}"
CLAUDE_DIR="${USER_HOME}/.claude"
SETTINGS_FILE="${CLAUDE_DIR}/settings.json"

mkdir -p "$CLAUDE_DIR"

# Build the env section to inject
python3 -c "
import json
import os

settings_path = '$SETTINGS_FILE'
new_env = {
    'ANTHROPIC_API_KEY': '',
    'ANTHROPIC_AUTH_TOKEN': '$AUTH_TOKEN',
    'ANTHROPIC_BASE_URL': '$BASE_URL',
    'ANTHROPIC_DEFAULT_HAIKU_MODEL': '$HAIKU_MODEL',
    'ANTHROPIC_DEFAULT_OPUS_MODEL': '$OPUS_MODEL',
    'ANTHROPIC_DEFAULT_SONNET_MODEL': '$SONNET_MODEL',
    'CLAUDE_CODE_SUBAGENT_MODEL': '$SUBAGENT_MODEL',
    'ANTHROPIC_LOG': '$LOG_LEVEL',
}

if os.path.exists(settings_path):
    with open(settings_path, 'r') as f:
        try:
            settings = json.load(f)
        except json.JSONDecodeError:
            settings = {}
else:
    settings = {}

if 'env' not in settings:
    settings['env'] = {}

settings['env'].update(new_env)

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
"

chown -R "${_REMOTE_USER:-root}:${_REMOTE_USER:-root}" "$CLAUDE_DIR"

echo "Claude Code Ollama backend configured in $SETTINGS_FILE"
