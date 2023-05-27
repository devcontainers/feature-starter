# Run this in Windows PowerShell as non-admin
# Please make sure winget is is installed
# https://apps.microsoft.com/store/detail/app-installer/
# https://github.com/microsoft/winget-cli
# https://github.com/microsoft/winget-cli/issues/210
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows sudo
sudo "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows winget
sudo "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows chocolatey
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows scoop
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows dotnet-tools
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows nvm
sudo "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pwsh
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pip
# Setup environment
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup environment
try {
  gh auth status
} catch {
  gh auth login
}
gh config set -h github.com git_protocol https
gh auth status

git-credential-manager configure
git-credential-manager diagnose
sudo winget install --id Microsoft.PowerToys
