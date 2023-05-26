param (
  [Parameter(Mandatory = $true)]
  [string]$scriptPath,
  [Parameter(Mandatory = $true)]
  [string]$script,
  [Parameter(Mandatory = $false)]
  [string]$commandPath,
  [Parameter(Mandatory = $false)]
  [string]$command
)

$projectRoot = "$PSCommandPath" | Split-Path -Parent
$scriptsRoot = "$projectRoot/.devcontainer/scripts"
& "$scriptsRoot/setup/environment.ps1"
#& "$DEVCONTAINER_SCRIPTS_ROOT/utils/gui-sound.ps1"
& "$DEVCONTAINER_SCRIPTS_ROOT/setup/submodules.ps1" | Out-Null
$executionRoot = "$DEVCONTAINER_SCRIPTS_ROOT/$scriptPath"
Push-Location "$executionRoot"
try {
  if ($command -eq $null) {
    $result = & "./$script.ps1"
  }
  else {
    $result = & "./$script.ps1" "$commandPath" "$command"
  }
}
finally {
  Pop-Location
}

return $result
