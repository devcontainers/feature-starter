#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Simplified Terraform Installation Script
# Focuses only on Terraform installation with improved error handling
#-------------------------------------------------------------------------------------------------------------

set -euo pipefail

# Configuration
TERRAFORM_VERSION="${VERSION:-"latest"}"
TERRAFORM_SHA256="${TERRAFORM_SHA256:-"automatic"}"
CUSTOM_DOWNLOAD_SERVER="${CUSTOMDOWNLOADSERVER:-""}"
KEYSERVER_PROXY="${HTTPPROXY:-"${HTTP_PROXY:-""}"}"

# Constants
HASHICORP_RELEASES_URL="https://releases.hashicorp.com"
if [ -n "${CUSTOM_DOWNLOAD_SERVER}" ]; then
    HASHICORP_RELEASES_URL="${CUSTOM_DOWNLOAD_SERVER}"
fi

TERRAFORM_GPG_KEY="72D7468F"
WORK_DIR="/tmp/terraform-install-$$"

# Architecture detection with better support
get_architecture() {
    local arch="$(uname -m)"
    case ${arch} in
        x86_64) echo "amd64";;
        aarch64 | armv8*) echo "arm64";;
        aarch32 | armv7* | armvhf*) echo "arm";;
        i?86) echo "386";;
        *) 
            echo "ERROR: Architecture ${arch} is not supported" >&2
            exit 1
            ;;
    esac
}

# Check if running as root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "ERROR: Script must be run as root. Use sudo, su, or add 'USER root' to your Dockerfile." >&2
        exit 1
    fi
}

# Install required packages
install_dependencies() {
    echo "Installing required dependencies..."
    export DEBIAN_FRONTEND=noninteractive
    
    if [ "$(find /var/lib/apt/lists/* 2>/dev/null | wc -l)" = "0" ]; then
        apt-get update -y
    fi
    
    apt-get -y install --no-install-recommends \
        curl \
        ca-certificates \
        gnupg2 \
        dirmngr \
        coreutils \
        unzip \
        git
}

# Get available GPG keyservers with proxy support
get_gpg_key_servers() {
    declare -A keyservers_curl_map=(
        ["hkps://keyserver.ubuntu.com"]="https://keyserver.ubuntu.com"
        ["hkps://keys.openpgp.org"]="https://keys.openpgp.org"
        ["hkps://keyserver.pgp.com"]="https://keyserver.pgp.com"
    )

    local curl_args=""
    local keyserver_reachable=false

    if [ -n "${KEYSERVER_PROXY}" ]; then
        curl_args="--proxy ${KEYSERVER_PROXY}"
        echo "Using proxy for keyserver checks: ${KEYSERVER_PROXY}" >&2
    fi

    for keyserver in "${!keyservers_curl_map[@]}"; do
        local keyserver_curl_url="${keyservers_curl_map[${keyserver}]}"
        if curl -s ${curl_args} --max-time 5 "${keyserver_curl_url}" > /dev/null 2>&1; then
            echo "keyserver ${keyserver}"
            keyserver_reachable=true
        else
            echo "Keyserver ${keyserver} is not reachable." >&2
        fi
    done

    if ! $keyserver_reachable; then
        echo "ERROR: No keyserver is reachable." >&2
        exit 1
    fi
}

# Get latest version from GitHub releases with proxy support
get_latest_terraform_version() {
    local api_url="https://api.github.com/repos/hashicorp/terraform/releases/latest"
    local version
    local curl_args=""
    
    if [ -n "${KEYSERVER_PROXY}" ]; then
        curl_args="--proxy ${KEYSERVER_PROXY}"
        echo "Using proxy for GitHub API: ${KEYSERVER_PROXY}"
    fi
    
    echo "Fetching latest Terraform version..."
    
    if command -v curl >/dev/null 2>&1; then
        version=$(curl -s ${curl_args} "${api_url}" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')
    else
        echo "ERROR: curl is required but not installed" >&2
        exit 1
    fi
    
    if [ -z "${version}" ]; then
        echo "ERROR: Failed to fetch latest version" >&2
        exit 1
    fi
    
    echo "${version}"
}

# Verify GPG signature with proxy support
verify_terraform_signature() {
    local version="$1"
    local work_dir="$2"
    local curl_args=""
    
    echo "Verifying Terraform signature..."
    
    # Set up curl args for proxy if configured
    if [ -n "${KEYSERVER_PROXY}" ]; then
        curl_args="--proxy ${KEYSERVER_PROXY}"
    fi
    
    # Set up temporary GPG home
    export GNUPGHOME="${work_dir}/gnupg"
    mkdir -p "${GNUPGHOME}"
    chmod 700 "${GNUPGHOME}"
    
    # Configure GPG with keyservers and proxy settings
    {
        echo "disable-ipv6"
        get_gpg_key_servers
    } > "${GNUPGHOME}/dirmngr.conf"
    
    # Set up GPG keyserver options for proxy
    local keyring_args=""
    if [ -n "${KEYSERVER_PROXY}" ]; then
        keyring_args="--keyserver-options http-proxy=${KEYSERVER_PROXY}"
    fi
    
    # Import HashiCorp GPG key with retry
    local retry_count=0
    local max_retries=3
    
    while [ "${retry_count}" -lt "${max_retries}" ]; do
        echo "Attempting to import GPG key (attempt $((retry_count + 1))/${max_retries})..."
        if gpg --recv-keys ${keyring_args} "${TERRAFORM_GPG_KEY}" 2>/dev/null; then
            break
        fi
        
        retry_count=$((retry_count + 1))
        if [ "${retry_count}" -lt "${max_retries}" ]; then
            echo "GPG key import failed, retrying in 5s..."
            sleep 5
        fi
    done
    
    if [ "${retry_count}" -eq "${max_retries}" ]; then
        echo "ERROR: Failed to import GPG key after ${max_retries} attempts" >&2
        exit 1
    fi
    
    # Download and verify checksums with proxy support
    echo "Downloading checksums..."
    curl -sSL ${curl_args} -o "${work_dir}/terraform_SHA256SUMS" \
        "${HASHICORP_RELEASES_URL}/terraform/${version}/terraform_${version}_SHA256SUMS"
    
    curl -sSL ${curl_args} -o "${work_dir}/terraform_SHA256SUMS.sig" \
        "${HASHICORP_RELEASES_URL}/terraform/${version}/terraform_${version}_SHA256SUMS.${TERRAFORM_GPG_KEY}.sig"
    
    if ! gpg --verify "${work_dir}/terraform_SHA256SUMS.sig" "${work_dir}/terraform_SHA256SUMS"; then
        echo "ERROR: GPG signature verification failed" >&2
        exit 1
    fi
    
    echo "GPG signature verification successful"
}

# Download and install Terraform with proxy support
install_terraform() {
    local version="$1"
    local architecture="$2"
    local work_dir="$3"
    local curl_args=""
    
    local terraform_filename="terraform_${version}_linux_${architecture}.zip"
    local download_url="${HASHICORP_RELEASES_URL}/terraform/${version}/${terraform_filename}"
    
    if [ -n "${KEYSERVER_PROXY}" ]; then
        curl_args="--proxy ${KEYSERVER_PROXY}"
        echo "Using proxy for downloads: ${KEYSERVER_PROXY}"
    fi
    
    echo "Downloading Terraform ${version} for ${architecture}..."
    
    # Download Terraform
    if ! curl -sSL ${curl_args} -o "${work_dir}/${terraform_filename}" "${download_url}"; then
        echo "ERROR: Failed to download Terraform" >&2
        exit 1
    fi
    
    # Verify checksum if not in dev mode
    if [ "${TERRAFORM_SHA256}" != "dev-mode" ]; then
        cd "${work_dir}"
        
        if [ "${TERRAFORM_SHA256}" = "automatic" ]; then
            verify_terraform_signature "${version}" "${work_dir}"
            if ! sha256sum --ignore-missing -c terraform_SHA256SUMS; then
                echo "ERROR: Checksum verification failed" >&2
                exit 1
            fi
        else
            echo "${TERRAFORM_SHA256} *${terraform_filename}" > custom_checksum
            if ! sha256sum -c custom_checksum; then
                echo "ERROR: Custom checksum verification failed" >&2
                exit 1
            fi
        fi
        
        echo "Checksum verification successful"
    fi
    
    # Extract and install
    echo "Installing Terraform..."
    if ! unzip -q "${work_dir}/${terraform_filename}" -d "${work_dir}"; then
        echo "ERROR: Failed to extract Terraform" >&2
        exit 1
    fi
    
    if ! mv "${work_dir}/terraform" /usr/local/bin/terraform; then
        echo "ERROR: Failed to install Terraform to /usr/local/bin/" >&2
        exit 1
    fi
    
    chmod +x /usr/local/bin/terraform
    echo "Terraform installation completed successfully"
}

# Cleanup function
cleanup() {
    if [ -n "${WORK_DIR:-}" ] && [ -d "${WORK_DIR}" ]; then
        rm -rf "${WORK_DIR}"
    fi
    
    if [ -n "${GNUPGHOME:-}" ] && [ -d "${GNUPGHOME}" ]; then
        rm -rf "${GNUPGHOME}"
    fi
    
    # Clean up apt cache
    rm -rf /var/lib/apt/lists/*
}

# Set up cleanup trap
trap cleanup EXIT

# Main execution
main() {
    echo "Starting Terraform installation..."
    
    # Show proxy configuration if set
    if [ -n "${KEYSERVER_PROXY}" ]; then
        echo "Proxy configuration detected: ${KEYSERVER_PROXY}"
    fi
    
    # Preliminary checks
    check_root
    
    # Get architecture
    local architecture
    architecture=$(get_architecture)
    echo "Detected architecture: ${architecture}"
    
    # Create working directory
    mkdir -p "${WORK_DIR}"
    
    # Install dependencies
    install_dependencies
    
    # Determine version
    if [ "${TERRAFORM_VERSION}" = "latest" ]; then
        TERRAFORM_VERSION=$(get_latest_terraform_version)
    fi
    echo "Installing Terraform version: ${TERRAFORM_VERSION}"
    
    # Install Terraform
    install_terraform "${TERRAFORM_VERSION}" "${architecture}" "${WORK_DIR}"
    
    # Verify installation
    if terraform version; then
        echo "Terraform installation verified successfully!"
    else
        echo "ERROR: Terraform installation verification failed" >&2
        exit 1
    fi
}

# Run main function
main "$@"