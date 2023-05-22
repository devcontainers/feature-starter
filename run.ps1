param (
    [Parameter(Mandatory=$true)]
    [string]$scriptPath,
    [Parameter(Mandatory=$true)]
    [string]$script,
    [Parameter(Mandatory=$false)]
    [string]$command
)

$projectRoot="$PSCommandPath" | Split-Path -Parent
$scriptsRoot="$projectRoot/scripts"
& "$scriptsRoot/setup/set-env-vars.ps1"
$executionRoot="$scriptsRoot/$scriptPath"
Push-Location "$executionRoot"
try {
  if ($command -eq $null) {
      $result = & "./$script.ps1"
  } else {
      $result = & "./$script.ps1" -command "$command"
  }
} finally {
  Pop-Location
}

return $result
