#!/bin/sh
set -e

echo "Activating feature 'claude-code-hooks'"

REPO="${REPOSITORY:-https://github.com/mrrobot0985/claude-code-hooks.git}"
BRANCH="${BRANCH:-main}"
INSTALL_STATUSLINE="${INSTALLSTATUSLINE:-true}"

USER_HOME="${_REMOTE_USER_HOME:-/home/${_REMOTE_USER:-$(whoami)}}"
CLAUDE_DIR="${USER_HOME}/.claude"
HOOKS_DIR="${CLAUDE_DIR}/hooks"
SETTINGS_FILE="${CLAUDE_DIR}/settings.json"

# Ensure dependencies
if ! command -v git >/dev/null 2>&1; then
    echo "Installing git..."
    if command -v apt-get >/dev/null 2>&1; then
        apt-get update && apt-get install -y --no-install-recommends git jq
        apt-get clean && rm -rf /var/lib/apt/lists/*
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache git jq
    elif command -v yum >/dev/null 2>&1; then
        yum install -y git jq
    elif command -v dnf >/dev/null 2>&1; then
        dnf install -y git jq
    else
        echo "WARNING: Could not install git/jq automatically. Ensure they are available."
    fi
fi

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

mkdir -p "$CLAUDE_DIR"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Cloning hooks from $REPO (branch: $BRANCH)..."
git clone --depth 1 --branch "$BRANCH" "$REPO" "$TMP_DIR/repo"

echo "Installing hooks to $HOOKS_DIR..."
mkdir -p "$HOOKS_DIR"
for dir in agent session turn lib config; do
    if [ -d "$TMP_DIR/repo/$dir" ]; then
        cp -r "$TMP_DIR/repo/$dir" "$HOOKS_DIR/"
    else
        echo "WARNING: directory '$dir' not found in cloned repo"
    fi
done

# Ensure scripts are executable
find "$HOOKS_DIR" -type f -name "*.sh" -exec chmod +x {} \;

# Merge settings.hooks.json into ~/.claude/settings.json
if [ -f "$HOOKS_DIR/config/settings.hooks.json" ]; then
    echo "Merging hooks configuration into $SETTINGS_FILE..."
    python3 -c "
import json
import os

settings_path = '$SETTINGS_FILE'

with open('$HOOKS_DIR/config/settings.hooks.json', 'r') as f:
    hooks_config = json.load(f)

# Remove schema key if present, it belongs at root
hooks_config.pop('\$schema', None)

if os.path.exists(settings_path):
    with open(settings_path, 'r') as f:
        try:
            settings = json.load(f)
        except json.JSONDecodeError:
            settings = {}
else:
    settings = {}

# Merge hooks config — overwrite hooks key, merge other keys
for key, value in hooks_config.items():
    if key == 'hooks':
        settings['hooks'] = value
    else:
        settings[key] = value

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
"
fi

# Optionally merge status line config
if [ "$INSTALL_STATUSLINE" = "true" ] && [ -f "$HOOKS_DIR/config/settings.statusline.json" ]; then
    echo "Merging status line configuration into $SETTINGS_FILE..."
    python3 -c "
import json
import os

settings_path = '$SETTINGS_FILE'

with open('$HOOKS_DIR/config/settings.statusline.json', 'r') as f:
    statusline_config = json.load(f)

statusline_config.pop('\$schema', None)

with open(settings_path, 'r') as f:
    settings = json.load(f)

for key, value in statusline_config.items():
    settings[key] = value

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
"
fi

# Fix ownership
chown -R "${_REMOTE_USER:-root}:${_REMOTE_USER:-root}" "$CLAUDE_DIR"

echo "Claude Code hooks installed to $HOOKS_DIR"
echo "Configuration written to $SETTINGS_FILE"
