Write-Host "setup/windows/chocolatey.ps1"
# https://chocolatey.org/
try {
  cup all -y
  if ($LASTEXITCODE -ne 0) { throw Write-Host "cup all -y failed"; "Exit code is $LASTEXITCODE" }
} catch {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  refreshenv
  . $profile
}

choco feature enable -n allowGlobalConfirmation
choco feature enable -n useRememberedArgumentsForUpgrades
choco feature enable -n showDownloadProgress
choco feature enable -n showNonElevatedWarnings
choco install -y psqlodbc
choco install -y sqlserver-odbcdriver
choco install -y sql-server-management-studio
cup all -y
