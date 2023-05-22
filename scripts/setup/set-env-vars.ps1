if (-not (Get-Module Set-PsEnv)) {
  Install-Module -Name Set-PsEnv
}
Import-Module Set-PsEnv
$projectRoot="$PSCommandPath" | Split-Path -Parent | Split-Path -Parent | Split-Path -Parent
Push-Location "$projectRoot"
try {
    Set-PsEnv
} finally {
    Pop-Location
}

if ($PSVersionTable.PSEdition -eq 'Core') {
    $env:PSHELL="pwsh"
} else {
    $env:PSHELL="PowerShell"
}

Set-Alias -Name "pshell" -Value "$env:PSHELL"
$env:DEVCONTAINER_FEATURES_PROJECT_ROOT="$projectRoot"
$env:DEVCONTAINER_FEATURES_SOURCE_ROOT="$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/src"
$env:DEVCONTAINER_SCRIPTS_ROOT="$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/scripts"
