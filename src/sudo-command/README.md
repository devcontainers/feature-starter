
# Sudo Command (sudo-command)

Executes a sudo command

## Example Usage

```json
"features": {
    "ghcr.io/AlephZ-ai/devcontainer-features/sudo-command:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | User to run command as | string | automatic |
| command | command to be executed as root (will be forwarded as is to a 'bash -c <command>' line) | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/AlephZ-ai/devcontainer-features/blob/main/src/sudo-command/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
