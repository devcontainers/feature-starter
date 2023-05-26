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
& "$scriptsRoot/setup/submodules.ps1"
$executionRoot = "$scriptsRoot/$scriptPath"
Push-Location "$executionRoot"
try {
  if ($command -eq $null) {
    $result = & "./$script.ps1"
  }
  else {
    $result = & "./$script.ps1" -commandPath "$commandPath" -command "$command"
  }
}
finally {
  Pop-Location
}

return $result
