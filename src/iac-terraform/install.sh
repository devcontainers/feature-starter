#!/usr/bin/env bash
set -e

# The install script for the devcontainer feature
# Variables are passed from devcontainer-feature.json

TOOL=${TOOL:-"terraform"}
VERSION=${VERSION:-"latest"}
INSTALL_TFSWITCH=${INSTALLTFSWITCH:-true}
INSTALL_TERRAGRUNT=${INSTALLTERRAGRUNT:-false}
TERRAGRUNT_VERSION=${TERRAGRUNTVERSION:-"latest"}
INSTALL_TFLINT=${INSTALLTFLINT:-true}
TFLINT_VERSION=${TFLINTVERSION:-"latest"}
INSTALL_TERRAFORM_DOCS=${INSTALLTERRAFORMDOCS:-true}
TERRAFORM_DOCS_VERSION=${TERRAFORMDOCSVERSION:-"latest"}
INSTALL_TERRASCAN=${INSTALLTERRASCAN:-true}
TERRASCAN_VERSION=${TERRASCANVERSION:-"latest"}
INSTALL_TRIVY=${INSTALLTRIVY:-true}
TRIVY_VERSION=${TRIVYVERSION:-"latest"}
INSTALL_CHECKOV=${INSTALLCHECKOV:-true}
CHECKOV_VERSION=${CHECKOVVERSION:-"latest"}
INSTALL_PRECOMMIT=${INSTALLPRECOMMIT:-true}
PRECOMMIT_VERSION=${PRECOMMITVERSION:-"latest"}
INSTALL_INFRACOST=${INSTALLINFRACOST:-false}
INFRACOST_VERSION=${INFRACOSTVERSION:-"latest"}

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

install_tflint() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        ver=$(get_latest_github_release "terraform-linters/tflint")
    fi
    echo "Installing TFLint version ${ver}..."
    local arch=$(dpkg --print-architecture)
    if [ "${arch}" = "amd64" ]; then arch="amd64"; elif [ "${arch}" = "arm64" ]; then arch="arm64"; else echo "Unsupported architecture: ${arch}"; exit 1; fi
    wget -q "https://github.com/terraform-linters/tflint/releases/download/v${ver}/tflint_linux_${arch}.zip" -O /tmp/tflint.zip
    unzip -q -o /tmp/tflint.zip -d /usr/local/bin
    rm /tmp/tflint.zip
    chmod +x /usr/local/bin/tflint
}

install_terraform_docs() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        ver=$(get_latest_github_release "terraform-docs/terraform-docs")
    fi
    echo "Installing terraform-docs version ${ver}..."
    local arch=$(dpkg --print-architecture)
    if [ "${arch}" = "amd64" ]; then arch="amd64"; elif [ "${arch}" = "arm64" ]; then arch="arm64"; else echo "Unsupported architecture: ${arch}"; exit 1; fi
    wget -q "https://github.com/terraform-docs/terraform-docs/releases/download/v${ver}/terraform-docs-v${ver}-linux-${arch}.tar.gz" -O /tmp/terraform-docs.tar.gz
    tar -xzf /tmp/terraform-docs.tar.gz -C /usr/local/bin terraform-docs
    rm /tmp/terraform-docs.tar.gz
    chmod +x /usr/local/bin/terraform-docs
}

install_terrascan() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        ver=$(get_latest_github_release "tenable/terrascan")
    fi
    echo "Installing Terrascan version ${ver}..."
    local arch=$(dpkg --print-architecture)
    local terrascan_arch=""
    if [ "${arch}" = "amd64" ]; then terrascan_arch="x86_64"; elif [ "${arch}" = "arm64" ]; then terrascan_arch="arm64"; else echo "Unsupported architecture: ${arch}"; exit 1; fi
    wget -q "https://github.com/tenable/terrascan/releases/download/v${ver}/terrascan_${ver}_Linux_${terrascan_arch}.tar.gz" -O /tmp/terrascan.tar.gz
    tar -xzf /tmp/terrascan.tar.gz -C /usr/local/bin terrascan
    rm /tmp/terrascan.tar.gz
    chmod +x /usr/local/bin/terrascan
}

install_trivy() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        echo "Installing latest Trivy..."
        curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
    else
        ver=$(echo "${ver}" | sed 's/^v//')
        echo "Installing Trivy version v${ver}..."
        curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin "v${ver}"
    fi
}

install_python_tools() {
    echo "Installing Python and Pip..."
    apt_get_update
    apt-get install -y python3 python3-pip python3-venv
    
    if [ "${INSTALL_CHECKOV}" = "true" ]; then
        local ver=${CHECKOV_VERSION}
        echo "Installing Checkov in isolated virtual environment..."
        python3 -m venv /opt/checkov-venv
        /opt/checkov-venv/bin/pip install --upgrade pip
        if [ "${ver}" = "latest" ]; then
            /opt/checkov-venv/bin/pip install checkov
        else
            ver=$(echo "${ver}" | sed 's/^v//')
            /opt/checkov-venv/bin/pip install "checkov==${ver}"
        fi
        ln -sf /opt/checkov-venv/bin/checkov /usr/local/bin/checkov
    fi
    
    if [ "${INSTALL_PRECOMMIT}" = "true" ]; then
        local ver=${PRECOMMIT_VERSION}
        echo "Installing pre-commit in isolated virtual environment..."
        python3 -m venv /opt/pre-commit-venv
        /opt/pre-commit-venv/bin/pip install --upgrade pip
        if [ "${ver}" = "latest" ]; then
            /opt/pre-commit-venv/bin/pip install pre-commit
        else
            ver=$(echo "${ver}" | sed 's/^v//')
            /opt/pre-commit-venv/bin/pip install "pre-commit==${ver}"
        fi
        ln -sf /opt/pre-commit-venv/bin/pre-commit /usr/local/bin/pre-commit
    fi
}

install_infracost() {
    local ver=$1
    if [ "${ver}" = "latest" ]; then
        echo "Installing latest Infracost..."
        curl -fsSL https://raw.githubusercontent.com/infracost/cli/main/scripts/install.sh | sh
    else
        ver=$(echo "${ver}" | sed 's/^v//')
        echo "Installing Infracost version v${ver}..."
        curl -fsSL https://raw.githubusercontent.com/infracost/cli/main/scripts/install.sh | INFRACOST_VERSION="v${ver}" sh
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

# Install TFLint
if [ "${INSTALL_TFLINT}" = "true" ] && [ "${TFLINT_VERSION}" != "none" ]; then
    install_tflint "${TFLINT_VERSION}"
fi

# Install terraform-docs
if [ "${INSTALL_TERRAFORM_DOCS}" = "true" ] && [ "${TERRAFORM_DOCS_VERSION}" != "none" ]; then
    install_terraform_docs "${TERRAFORM_DOCS_VERSION}"
fi

# Install Terrascan
if [ "${INSTALL_TERRASCAN}" = "true" ] && [ "${TERRASCAN_VERSION}" != "none" ]; then
    install_terrascan "${TERRASCAN_VERSION}"
fi

# Install Trivy
if [ "${INSTALL_TRIVY}" = "true" ] && [ "${TRIVY_VERSION}" != "none" ]; then
    install_trivy "${TRIVY_VERSION}"
fi

# Install Python tools (Checkov & pre-commit)
if [ "${INSTALL_CHECKOV}" = "true" ] || [ "${INSTALL_PRECOMMIT}" = "true" ]; then
    install_python_tools
fi

# Install Infracost
if [ "${INSTALL_INFRACOST}" = "true" ] && [ "${INFRACOST_VERSION}" != "none" ]; then
    install_infracost "${INFRACOST_VERSION}"
fi

# Clean up
echo "Cleaning up apt caches..."
rm -rf /var/lib/apt/lists/*

echo "Done!"
