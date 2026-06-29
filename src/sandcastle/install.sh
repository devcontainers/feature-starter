#!/bin/sh
set -e

echo "Activating feature 'sandcastle'"

VERSION="${VERSION:-latest}"
PROVIDER_CHECK="${PROVIDERCHECK:-true}"

# Check for sandbox providers
if [ "$PROVIDER_CHECK" = "true" ]; then
    has_provider=false
    if command -v docker >/dev/null 2>&1; then
        echo "Docker found"
        has_provider=true
    fi
    if command -v podman >/dev/null 2>&1; then
        echo "Podman found"
        has_provider=true
    fi
    if command -v vercel >/dev/null 2>&1; then
        echo "Vercel CLI found"
        has_provider=true
    fi

    if [ "$has_provider" != "true" ]; then
        echo "ERROR: No sandbox provider found (docker, podman, or vercel)"
        echo "Sandcastle requires a sandbox provider to function"
        exit 1
    fi
fi

# Install sandcastle
echo "Installing @ai-hero/sandcastle..."
if [ "$VERSION" = "latest" ]; then
    npm install -g @ai-hero/sandcastle
else
    npm install -g "@ai-hero/sandcastle@${VERSION}"
fi

echo "Sandcastle installed successfully"
echo "NOTE: Configure CLAUDE_CODE_OAUTH_TOKEN or ANTHROPIC_API_KEY in .sandcastle/.env after initialization"
