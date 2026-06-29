# Claude Code Ollama Backend

Configures Claude Code to use an [Ollama](https://ollama.com/) backend for model requests instead of Anthropic's API.

## Options

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `baseUrl` | string | `"http://localhost:11434"` | Ollama API base URL |
| `authToken` | string | `"ollama"` | Auth token for the Ollama backend |
| `haikuModel` | string | `"minimax-m2.5:cloud"` | Default Haiku model identifier |
| `opusModel` | string | `"glm-5.2:cloud"` | Default Opus model identifier |
| `sonnetModel` | string | `"kimi-k2.6:cloud"` | Default Sonnet model identifier |
| `subagentModel` | string | `"kimi-k2.7-code:cloud"` | Subagent model identifier |
| `logLevel` | string | `"error"` | Anthropic client log level |

## Notes

- This feature modifies `~/.claude/settings.json` to inject model environment variables.
- Ollama must be running and accessible at the configured `baseUrl`.
- This feature pairs well with `ghcr.io/anthropics/devcontainer-features/claude-code` for installing Claude Code itself.
