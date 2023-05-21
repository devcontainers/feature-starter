# Please make sure the winget is is installed
# Run this in Windows PowerShell as admin
try {
  cup all -y
} catch {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

choco feature enable -n allowGlobalConfirmation
choco feature enable -n useRememberedArgumentsForUpgrades
choco feature enable -n showDownloadProgress
choco feature enable -n showNonElevatedWarnings
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
refreshenv
