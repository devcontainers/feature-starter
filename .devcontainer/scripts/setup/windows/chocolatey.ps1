# https://chocolatey.org/
try {
  cup all -y
  if ($LASTEXITCODE -ne 0) { throw "Exit code is $LASTEXITCODE" }
} catch {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

$env:ChocolateyInstall = [Environment]::GetEnvironmentVariable("ChocolateyInstall", [EnvironmentVariableTarget]::Machine)
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
choco feature enable -n allowGlobalConfirmation
choco feature enable -n useRememberedArgumentsForUpgrades
choco feature enable -n showDownloadProgress
choco feature enable -n showNonElevatedWarnings
