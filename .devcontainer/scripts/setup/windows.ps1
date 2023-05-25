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
sudo "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pwsh-modules
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
Write-Host "Don't forget to set your git credentials:"
Write-Host 'git config --global user.name "Your Name"'
Write-Host 'git config --global user.email "youremail@yourdomain.com"'
sudo winget install --id Microsoft.PowerToys
