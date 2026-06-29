# Claude Code Privacy

Configures Claude Code with privacy-hardened defaults to minimize data collection and external communication.

## Options

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `disableTelemetry` | boolean | `true` | Disable telemetry collection |
| `disableErrorReporting` | boolean | `true` | Disable automatic error reporting |
| `disableFeedbackCommand` | boolean | `true` | Disable the `/feedback` command |
| `disableUpdates` | boolean | `true` | Disable automatic updates |
| `disableNonessentialTraffic` | boolean | `true` | Disable non-essential network traffic |
| `disableFeedbackSurvey` | boolean | `true` | Disable feedback surveys |
| `skipPromptHistory` | boolean | `false` | Skip saving prompt history |
| `cleanupPeriodDays` | integer | `30` | Days before cleaning up old sessions |

## What It Does

When applied, this feature sets environment variables and configuration values that:

- Disable telemetry and error reporting to Anthropic
- Block automatic updates and update checks
- Disable feedback commands and surveys
- Reduce non-essential network traffic
- Configure session cleanup retention

## Notes

- This feature modifies `~/.claude/settings.json`.
- This feature pairs well with `claude-code-ollama` for a fully local, privacy-respecting setup.
