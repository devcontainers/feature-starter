# Define an array of module names
$modules = @('Pester', 'Set-PsEnv')

foreach ($module in $modules) {
    Install-Module -Force -SkipPublisherCheck -Name $module
}

# Function to install modules
function Install-Modules {
    param($ShellCommand)
    foreach ($module in $modules) {
        Start-Process -FilePath $ShellCommand -ArgumentList "-Command Install-Module -Force -SkipPublisherCheck -Name $module" -Wait -NoNewWindow
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
