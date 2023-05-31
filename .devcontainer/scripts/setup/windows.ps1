# Run this in Windows PowerShell as non-admin
# Please make sure winget is is installed
# https://apps.microsoft.com/store/detail/app-installer/
# https://github.com/microsoft/winget-cli
# https://github.com/microsoft/winget-cli/issues/210
Write-Host "setup/windows.ps1"
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pre-sudo
sudo "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows post-sudo
Write-Host "WARNING: Please restart shell to get latest environment variables"
