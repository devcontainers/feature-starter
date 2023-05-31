Write-Host "setup/windows/pwsh.ps1"
# Define an array of module names
$modules = @('Pester', 'Set-PsEnv', 'posh-docker', 'posh-git', 'lazy-posh-git')
# Function to install modules
function Install-Modules {
  param($ShellCommand)
  Start-Process -FilePath $ShellCommand -ArgumentList '-Command if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force; }; Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber; Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber -AllowPrerelease; Set-Alias -Name awk -Value gawk;' -Wait -NoNewWindow
  foreach ($module in $modules) {
    Start-Process -FilePath $ShellCommand -ArgumentList "-Command Install-Module -Name $module -Force -SkipPublisherCheck -AllowClobber;" -Wait -NoNewWindow
  }
}

# PowerShell Core (pwsh)
if (Get-Command pwsh -ErrorAction SilentlyContinue) {
  Install-Modules "pwsh"
}
else {
  Write-Host "PowerShell Core is not installed"
}

# PowerShell Core Preview (pwsh-preview)
if (Get-Command pwsh-preview -ErrorAction SilentlyContinue) {
  Install-Modules "pwsh-preview"
}
else {
  Write-Host "PowerShell Core Preview is not installed"
}
