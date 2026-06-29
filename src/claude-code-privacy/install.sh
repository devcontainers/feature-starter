#!/bin/sh
set -e

echo "Activating feature 'claude-code-privacy'"

# Convert boolean options to string values for env vars
bool_to_str() {
    if [ "$1" = "true" ]; then
        echo "1"
    else
        echo "0"
    fi
}

DISABLE_TELEMETRY="$(bool_to_str "${DISABLETELEMETRY:-true}")"
DISABLE_ERROR_REPORTING="$(bool_to_str "${DISABLEERRORREPORTING:-true}")"
DISABLE_FEEDBACK_COMMAND="$(bool_to_str "${DISABLEFEEDBACKCOMMAND:-true}")"
DISABLE_UPDATES="$(bool_to_str "${DISABLEUPDATES:-true}")"
DISABLE_NONESSENTIAL_TRAFFIC="$(bool_to_str "${DISABLENONESSENTIALTRAFFIC:-true}")"
DISABLE_FEEDBACK_SURVEY="$(bool_to_str "${DISABLEFEEDBACKSURVEY:-true}")"
SKIP_PROMPT_HISTORY="$(bool_to_str "${SKIPPROMPTHISTORY:-false}")"
CLEANUP_PERIOD_DAYS="${CLEANUPPERIODDAYS:-30}"

USER_HOME="${_REMOTE_USER_HOME:-/home/${_REMOTE_USER:-$(whoami)}}"
CLAUDE_DIR="${USER_HOME}/.claude"
SETTINGS_FILE="${CLAUDE_DIR}/settings.json"

mkdir -p "$CLAUDE_DIR"

python3 -c "
import json
import os

settings_path = '$SETTINGS_FILE'

new_env = {
    'BASH_DEFAULT_TIMEOUT_MS': '300000',
    'CLAUDE_CODE_ALWAYS_ENABLE_EFFORT': '1',
    'CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING': '0',
    'CLAUDE_CODE_DISABLE_AUTO_MEMORY': '0',
    'CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY': '$DISABLE_FEEDBACK_SURVEY',
    'CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS': '0',
    'CLAUDE_CODE_DISABLE_MOUSE': '0',
    'CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC': '$DISABLE_NONESSENTIAL_TRAFFIC',
    'CLAUDE_CODE_DISABLE_NONSTREAMING_FALLBACK': '0',
    'CLAUDE_CODE_ENABLE_TELEMETRY': '0',
    'CLAUDE_CODE_SKIP_PROMPT_HISTORY': '$SKIP_PROMPT_HISTORY',
    'DISABLE_AUTOUPDATER': '$DISABLE_UPDATES',
    'DISABLE_ERROR_REPORTING': '$DISABLE_ERROR_REPORTING',
    'DISABLE_FEEDBACK_COMMAND': '$DISABLE_FEEDBACK_COMMAND',
    'DISABLE_PROMPT_CACHING_SONNET': '0',
    'DISABLE_TELEMETRY': '$DISABLE_TELEMETRY',
    'DISABLE_UPDATES': '$DISABLE_UPDATES',
}

new_settings = {
    'cleanupPeriodDays': int('$CLEANUP_PERIOD_DAYS'),
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
settings.update(new_settings)

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
"

chown -R "${_REMOTE_USER:-root}:${_REMOTE_USER:-root}" "$CLAUDE_DIR"

echo "Claude Code privacy settings configured in $SETTINGS_FILE"
