
# Dotnet CLI (dotnet)

Installs the .NET CLI with preview, latest, and lts dotnet versions of the SDK and runtime.

## Example Usage

```json
"features": {
    "ghcr.io/AlephZ-ai/devcontainer-features/dotnet:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| tools | Comma seperated list dotnet tools to install globally | string | - |

## Customizations

### VS Code Extensions

- `ms-dotnettools.csharp`



## OS Support

This Feature should work on recent versions of Debian/Ubuntu-based distributions with the `apt` package manager installed.

`bash` is required to execute the `install.sh` script.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/AlephZ-ai/devcontainer-features/blob/main/src/dotnet/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
