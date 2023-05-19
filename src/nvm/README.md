
# Node Version Manager with both lts and latest versions of Node.js (via nvm), yarn and pnpm (nvm)

Installs nvm, Node.js (lts and latest), yarn, pnpm, and needed dependencies.

## Example Usage

```json
"features": {
    "ghcr.io/AlephZ-ai/devcontainer-features/nvm:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | User to install nvm | string | automatic |
| nodeGypDependencies | Install dependencies to compile native node modules (node-gyp)? | boolean | true |
| packages | Comma seperated list of node packages to install globally | string | - |

## Customizations

### VS Code Extensions

- `dbaeumer.vscode-eslint`



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/AlephZ-ai/devcontainer-features/blob/main/src/nvm/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
