# Please make sure the winget is is installed
# Run this in Windows PowerShell as non-admin
& "$PSScriptRoot/scoop.ps1"
# Setup environment
refreshenv
./run setup environment
Write-Host "Don't forget to set your git credentials:"
Write-Host 'git config --global user.name "Your Name"'
Write-Host 'git config --global user.email "youremail@yourdomain.com"'
sudo winget install --id Microsoft.PowerToys
