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
# & "$env:DEVCONTAINER_SCRIPTS_ROOT/utils/gui-sound.ps1"
$executionRoot = "$env:DEVCONTAINER_SCRIPTS_ROOT/$scriptPath"
Push-Location "$executionRoot"
try {
  if ("$command" -eq "") {
    $result = & "./$script.ps1"
  }
  else {
    $result = & "./$script.ps1" "$commandPath" "$command"
  }

  if ($LASTEXITCODE -ne 0) { throw "Exit code is $LASTEXITCODE" }
}
finally {
  Pop-Location
}

return $result
