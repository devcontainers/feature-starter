
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
| username | If your sudo script needs access to a user so it can make modifications | string | automatic |
| command | command to be executed as root (will be forwarded as is to a 'bash -c <command>' line) | string | echo TEST=42 >> /etc/environment |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/AlephZ-ai/devcontainer-features/blob/main/src/sudo-command/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
