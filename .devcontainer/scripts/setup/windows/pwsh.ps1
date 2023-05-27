# Define an array of module names
$modules = @('Pester', 'Set-PsEnv')

# Function to install modules
function Install-Modules {
  param($ShellCommand)
  foreach ($module in $modules) {
    Start-Process -FilePath $ShellCommand -ArgumentList "-Command Import-Module PowerShellGet -ErrorAction Stop; Set-Alias -Name awk -Value gawk; Install-Module -Name $module -Force -SkipPublisherCheck -AllowClobber" -Wait -NoNewWindow
  }
}

# Windows PowerShell
if (Get-Command powershell -ErrorAction SilentlyContinue) { 
  Install-Modules "powershell"
}
else {
  Write-Host "Windows PowerShell is not installed"
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
