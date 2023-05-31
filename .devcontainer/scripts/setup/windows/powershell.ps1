Write-Host "setup/windows/powershell.ps1"
# Define an array of module names
$modules = @('Pester', 'Set-PsEnv', 'posh-docker', 'posh-git', 'lazy-posh-git')
# Windows PowerShell
Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber
Install-Module PowerShellGet -ErrorAction Stop -Force -SkipPublisherCheck -AllowClobber -AllowPrerelease
Set-Alias -Name awk -Value gawk
foreach ($module in $modules) {
  Install-Module -Name $module -Force -SkipPublisherCheck -AllowClobber
}
