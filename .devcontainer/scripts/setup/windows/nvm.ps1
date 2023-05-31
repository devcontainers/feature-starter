Write-Host "setup/windows/nvm.ps1"
nvm on
nvm version
# Install Node.js latest and lts
$nodes = 'latest', 'lts'
$packages = '@npmcli/fs', '@devcontainers/cli', 'dotenv-cli', 'typescript', 'npm-check-updates'

# You need to install nvm-windows before running these commands
# Download and install nvm-windows from https://github.com/coreybutler/nvm-windows/releases

# Make sure to restart your PowerShell console after installing nvm-windows
# Run this command to ensure nvm is installed: nvm version

foreach ($node in $nodes) {
    nvm install $node
    nvm use $node
    node --version
    npm install -g npm
    foreach ($package in $packages) {
        npm install -g $package
    }

    ncu -g -u
    ncu -u
}

nvm use latest
