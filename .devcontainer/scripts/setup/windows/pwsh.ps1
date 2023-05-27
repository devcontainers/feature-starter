# Define an array of module names
$modules = @('Pester', 'Set-PsEnv')

Install-Module -Name PowerShellGet -Force -SkipPublisherCheck -AllowClobber
Import-Module PowerShellGet -ErrorAction Stop
foreach ($module in $modules) {
  Install-Module -Name $module -Force -SkipPublisherCheck -AllowClobber
}

# Add awk alias
Set-Alias -Name awk -Value gawk
# Function to install modules
function Install-Modules {
    param($ShellCommand)
    foreach ($module in $modules) {
        Start-Process -FilePath $ShellCommand -ArgumentList "-Command Install-Module -Name PowerShellGet -Force -SkipPublisherCheck -AllowClobber; Import-Module PowerShellGet -ErrorAction Stop; Set-Alias -Name awk -Value gawk; Install-Module -Name $module -Force -SkipPublisherCheck -AllowClobber" -Wait -NoNewWindow
    }
}

# Windows PowerShell
if (Get-Command powershell -ErrorAction SilentlyContinue) {
    Install-Modules "powershell"
} else {
    Write-Output "Windows PowerShell is not installed"
}

# PowerShell Core (pwsh)
if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    Install-Modules "pwsh"
} else {
    Write-Output "PowerShell Core is not installed"
}

# PowerShell Core Preview (pwsh-preview)
if (Get-Command pwsh-preview -ErrorAction SilentlyContinue) {
    Install-Modules "pwsh-preview"
} else {
    Write-Output "PowerShell Core Preview is not installed"
}
