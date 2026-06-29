# Claude Code Hooks

Installs [claude-code-hooks](https://github.com/mrrobot0985/claude-code-hooks) — bash hooks for Claude Code lifecycle telemetry, state tracking, and policy enforcement.

## What It Installs

- `~/.claude/hooks/agent/` — Tool, permission, subagent, task hooks
- `~/.claude/hooks/session/` — Lifecycle, config, filesystem, worktree hooks
- `~/.claude/hooks/turn/` — Prompt, stop, notification hooks
- `~/.claude/hooks/lib/` — Shared state/logging helpers
- `~/.claude/hooks/config/` — Wiring templates
- Merges `config/settings.hooks.json` into `~/.claude/settings.json`

## Options

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `repository` | string | `"https://github.com/mrrobot0985/claude-code-hooks.git"` | Git repository URL containing the hooks |
| `branch` | string | `"main"` | Git branch, tag, or commit to checkout |
| `installStatusLine` | boolean | `true` | Also install the status line hook configuration |

## Notes

- Requires `git` and `jq`. The install script attempts to install them if missing.
- Hooks are copied to `~/.claude/hooks/` and wired into `~/.claude/settings.json`.
- State files are written to `.claude/state/` during hook execution.
