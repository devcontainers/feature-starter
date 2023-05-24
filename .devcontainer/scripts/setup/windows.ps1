# Please make sure the winget is is installed
# Run this in Windows PowerShell as non-admin
./run setup/windows scoop
# Setup environment
refreshenv
& "$DEVCONTAINER_FEATURES_PROJECT_ROOT/run" setup environment
Write-Host "Don't forget to set your git credentials:"
Write-Host 'git config --global user.name "Your Name"'
Write-Host 'git config --global user.email "youremail@yourdomain.com"'
sudo winget install --id Microsoft.PowerToys
