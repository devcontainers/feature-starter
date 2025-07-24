
# Terraform (terraform)

Installs the Terraform CLI. Auto-detects latest version and installs needed dependencies.

## Example Usage

```json
"features": {
    "ghcr.io/sethbacon/features/terraform:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Terraform version | string | latest |
| httpProxy | Connect to a keyserver using a proxy by configuring this option | string | - |


## Customizations

### VS Code Extensions

- `HashiCorp.terraform`

## Licensing

On August 10, 2023, HashiCorp announced a change of license for its products, including Terraform. After ~9 years of Terraform being open source under the MPL v2 license, it was to move under a non-open source BSL v1.1 license, starting from the next (1.6) version. See https://github.com/hashicorp/terraform/blob/main/LICENSE

## OS Support

This Feature should work on recent versions of Debian/Ubuntu-based distributions with the `apt` package manager installed.

`bash` is required to execute the `install.sh` script.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/devcontainers/features/blob/main/src/terraform/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
