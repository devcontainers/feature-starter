# Sandcastle

Installs [Sandcastle](https://github.com/mattpocock/sandcastle) for orchestrating AI coding agents in isolated sandboxes.

## Requirements

Sandcastle requires a sandbox provider to function. By default, this feature checks for one of:

- Docker
- Podman
- Vercel CLI

If none is found and `providerCheck` is `true`, the installation fails.

## Options

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `version` | string | `"latest"` | Version of `@ai-hero/sandcastle` to install |
| `providerCheck` | boolean | `true` | Fail if no sandbox provider is detected |

## Post-install

After installation, run `npx @ai-hero/sandcastle init` in your project to create the `.sandcastle/` directory. Configure your API credentials in `.sandcastle/.env`:

- `CLAUDE_CODE_OAUTH_TOKEN` (from `claude setup-token`)
- `ANTHROPIC_API_KEY`
