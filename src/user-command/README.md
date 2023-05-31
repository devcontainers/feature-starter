
# User Command (user-command)

Executes a user command

## Example Usage

```json
"features": {
    "ghcr.io/AlephZ-ai/devcontainer-features/user-command:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | User to run command as | string | automatic |
| command | command to be executed as username (will be forwarded as is to a 'su <username> -c <command>' line) | string | echo export TEST=42 >> "\$HOME/.bashrc" |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/AlephZ-ai/devcontainer-features/blob/main/src/user-command/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
