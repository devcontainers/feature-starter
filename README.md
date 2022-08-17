# Dev Container Features: Self Authoring Template

> This repo provides a starting point and example for creating your own custom [dev container features](), hosted for free on GitHub Container Registry.  The example in this repository follows the [**proposed**  dev container feature distribution specification](https://containers.dev/implementors/features-distribution/).  
>
> The proposed specification is in its _finalization_ phase and is subject to change.  To provide feedback to the specification, please leave a comment [on spec issue #70](https://github.com/devcontainers/spec/issues/70).  For more broad feedback regarding dev container features, please see [spec issue #61](https://github.com/devcontainers/spec/issues/61).

## Example Contents

This repository contains a _collection_ of two features - `hello` and `color`. These features serve as simple feature implementations.  Each sub-section below shows a sample `devcontainer.json` alongside example usage of the feature.

### `hello`

Running `hello` inside the built container will print the greeting provided to it via its `greeting` option.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/devcontainers/authoring-features/hello:1" {
            "greeting": "Hello"
        }
}
```

```bash
$ hello

Hello, user.
```

### `color`

Running `color` inside the built container will print your favorite color to standard out.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/devcontainers/authoring-features/color:1" {
            "favorite": "green"
        }
}
```

```bash
$ color

my favorite color is green
```

## Repo and Feature Structure

Similar to the [`devcontainers/features`](https://github.com/devcontainers/features) repo, this repository has a `src` folder.  Each feature has its own sub-folder, containing at least a `devcontainer-feature.json` and an entrypoint script `install.sh`. 

```
├── src
│   ├── hello
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
│   ├── color
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
|   ├── ...
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
...
```

An [implementing tool](https://containers.dev/supporting#tools) will composite [the documented dev container properties](https://containers.dev/implementors/features/#devcontainer-feature-json-properties) from the feature's `devcontainer-feature.json` file, and execute in the `install.sh` entrypoint script in the container during build time.  Implementing tools are also free to process attributes under the `customizations` property as desired.

### Options

All available options for a feature should be declared in the `devcontainer-feature.json`.  The syntax for the `options` property can be found in the [devcontainer feature json properties reference](https://containers.dev/implementors/features/#devcontainer-feature-json-properties).

For example, the `color` feature provides an enum of three possible options (`red`, `gold`, `green`).  If no option is provided in a user's `devcontainer.json`, the value is set to "red".

```json
    "options": {
        "favorite": {
            "type": "string",
            "enum": [
                "red",
                "gold",
                "green"
            ],
            "default": "red",
            "description": "Choose your favorite color."
        }
    }
```

Options are exported as feature-scoped environment variables.  The option name is captialized and sanitized according to [option resolution](https://containers.dev/implementors/features/#option-resolution).

```bash
#!/bin/bash

echo "Activating feature 'color'"
echo "The provided favorite color is: ${FAVORITE}"

...
```

## Distributing Features

### Versioning

Features are individually versioned by the `version` attribute in a feature's `devcontainer-feature.json`.  Features are versioned according to the semver specification. More details can be found in [the dev container feature specification](https://containers.dev/implementors/features/#versioning).

### Publishing

> NOTE: The Distribution spec can be [found here](https://containers.dev/implementors/features-distribution/) and is in its [finalization stage](https://github.com/devcontainers/spec/issues/70).

Features are meant to be easily sharable units of dev container configuration and installation code.  

This repo contains a GitHub Action [workflow](.github/workflows/release.yaml) that will publish each feature to GHCR.  By default, each feature will be prefixed with the `<owner/<repo>` names.  For example, the the two features in this repository can be referenced in a `devcontainer.json` with:

```
ghcr.io/devcontainers/authoring-features/color:1
ghcr.io/devcontainers/authoring-features/hello:1
```

'`devcontainers/authoring-features`' is known as the feature collection namespace.


### Marking Feature Public

Note that by default, GHCR packages are marked as `private`.  To stay within the free tier, features need to be marked as `public`.  