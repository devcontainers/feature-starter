#!/usr/bin/env bash
set -e

# The install script for the devcontainer feature
# Variables are passed from devcontainer-feature.json

TOOL=${TOOL:-"terraform"}
VERSION=${VERSION:-"latest"}
INSTALL_TFSWITCH=${INSTALLTFSWITCH:-true}
INSTALL_TERRAGRUNT=${INSTALLTERRAGRUNT:-false}
TERRAGRUNT_VERSION=${TERRAGRUNTVERSION:-"latest"}

# Clean up
rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Install dependencies
apt_get_update
apt-get install -y curl unzip wget jq software-properties-common dpkg

# Function to get latest GitHub release
get_latest_github_release() {
    local repo=$1
    curl -s "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name' | sed 's/^v//'
}

# Install Terraform
install_terraform() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        ver=$(get_latest_github_release "hashicorp/terraform")
    fi
    echo "Installing Terraform version ${ver}..."
    local arch=$(dpkg --print-architecture)
    if [ "${arch}" = "amd64" ]; then arch="amd64"; elif [ "${arch}" = "arm64" ]; then arch="arm64"; else echo "Unsupported architecture: ${arch}"; exit 1; fi
    wget -q "https://releases.hashicorp.com/terraform/${ver}/terraform_${ver}_linux_${arch}.zip" -O /tmp/terraform.zip
    unzip -q /tmp/terraform.zip -d /usr/local/bin
    rm /tmp/terraform.zip
    chmod +x /usr/local/bin/terraform
}

# Install OpenTofu
install_opentofu() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        ver=$(get_latest_github_release "opentofu/opentofu")
    fi
    echo "Installing OpenTofu version ${ver}..."
    local arch=$(dpkg --print-architecture)
    if [ "${arch}" = "amd64" ]; then arch="amd64"; elif [ "${arch}" = "arm64" ]; then arch="arm64"; else echo "Unsupported architecture: ${arch}"; exit 1; fi
    wget -q "https://github.com/opentofu/opentofu/releases/download/v${ver}/tofu_${ver}_linux_${arch}.zip" -O /tmp/tofu.zip
    unzip /tmp/tofu.zip tofu -d /usr/local/bin/
    rm /tmp/tofu.zip
    chmod +x /usr/local/bin/tofu
}

# Install Terragrunt
install_terragrunt() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        ver=$(get_latest_github_release "gruntwork-io/terragrunt")
    fi
    echo "Installing Terragrunt version ${ver}..."
    local arch=$(dpkg --print-architecture)
    if [ "${arch}" = "amd64" ]; then arch="amd64"; elif [ "${arch}" = "arm64" ]; then arch="arm64"; else echo "Unsupported architecture: ${arch}"; exit 1; fi
    wget -q "https://github.com/gruntwork-io/terragrunt/releases/download/v${ver}/terragrunt_linux_${arch}" -O /usr/local/bin/terragrunt
    chmod +x /usr/local/bin/terragrunt
    
    # Integrate Terragrunt with OpenTofu if selected
    if [ "${TOOL}" = "opentofu" ]; then
        echo "Configuring Terragrunt to use OpenTofu..."
        echo "export TERRAGRUNT_TFPATH=tofu" > /etc/profile.d/terragrunt-opentofu.sh
        chmod +x /etc/profile.d/terragrunt-opentofu.sh
    fi
}

# Install selected tool
if [ "${VERSION}" != "none" ]; then
    if [ "${TOOL}" = "terraform" ]; then
        install_terraform "${VERSION}"
    elif [ "${TOOL}" = "opentofu" ]; then
        install_opentofu "${VERSION}"
    fi
fi

# Install tfswitch
if [ "${INSTALL_TFSWITCH}" = "true" ]; then
    echo "Installing tfswitch..."
    curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
    
    # Optional integration if opentofu is selected
    if [ "${TOOL}" = "opentofu" ]; then
        echo "Configuring tfswitch to use OpenTofu..."
        echo "alias tfswitch='tfswitch --product opentofu'" > /etc/profile.d/tfswitch-opentofu.sh
        chmod +x /etc/profile.d/tfswitch-opentofu.sh
    fi
fi

# Install Terragrunt
if [ "${INSTALL_TERRAGRUNT}" = "true" ] && [ "${TERRAGRUNT_VERSION}" != "none" ]; then
    install_terragrunt "${TERRAGRUNT_VERSION}"
fi

echo "Done!"
