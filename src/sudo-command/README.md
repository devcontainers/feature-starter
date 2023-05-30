
# Bash Command (bash-command)

Executes a bash command

## Example Usage

```json
"features": {
    "ghcr.io/AlephZ-ai/devcontainer-features/bash-command:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | User to run command as | string | automatic |
| sudocommand | command to be executed as root (will be forwarded as is to a 'bash -l -c <command>' line) | string | - |
| usercommand | command to be executed as username (will be forwarded as is to a 'bash -l -c <command>' line) | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/AlephZ-ai/devcontainer-features/blob/main/src/bash-command/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
