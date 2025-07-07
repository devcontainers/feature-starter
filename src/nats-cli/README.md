
# NATS CLI (nats-cli)

Installs the NATS CLI. Auto-detects latest version and installs needed dependencies.

## Example Usage

```json
"features": {
    "ghcr.io/devcontainers/feature-nats/nats-cli:1": {
        "version": "latest"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select version of the GitHub CLI, if not latest. | string | latest |


## OS Support

This Feature should work on recent versions of Debian/Ubuntu-based distributions with the `apt` package manager installed.

`bash` is required to execute the `install.sh` script.

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/devcontainers/feature-starter/blob/main/src/hello/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
