# Define an array of module names
$modules = @('Pester', 'Set-PsEnv')
# Windows PowerShell
Import-Module PowerShellGet -ErrorAction Stop
Set-Alias -Name awk -Value gawk
foreach ($module in $modules) {
  Install-Module -Name $module -Force -SkipPublisherCheck -AllowClobber
}

# Function to install modules
function Install-Modules {
  param($ShellCommand)
  foreach ($module in $modules) {
    Start-Process -FilePath $ShellCommand -ArgumentList "-Command Import-Module PowerShellGet -ErrorAction Stop; Set-Alias -Name awk -Value gawk; Install-Module -Name $module -Force -SkipPublisherCheck -AllowClobber" -Wait -NoNewWindow
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
