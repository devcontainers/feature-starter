$projectRoot="$PSCommandPath" | Split-Path -Parent | Split-Path -Parent | Split-Path -Parent | Split-Path -Parent
Push-Location "$projectRoot/.devcontainer"
try {
    Import-Module Set-PsEnv
    Set-PsEnv
    if ($LASTEXITCODE -ne 0) { Write-Host "Set-PsEnv failed"; throw "Exit code is $LASTEXITCODE" }
  } catch {
    $env:DEVCONTAINER_FEATURES_PROJECT_NAME="devcontainer-features"
    $env:DEVCONTAINER_PROJECT_NAME="devcontainer"
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
$env:DEVCONTAINER_SCRIPTS_ROOT="$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/.devcontainer/scripts"
