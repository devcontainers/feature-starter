# Update submodules
$updateSubmodules = $false
Push-Location "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT"
try {
  $submodulePath = "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT\.devcontainer\dependencies\devcontainers\features"
  if (Test-Path $submodulePath) {
    $directoryInfo = Get-ChildItem $submodulePath | Measure-Object
    if ($directoryInfo.count -eq 0) {
      $updateSubmodules = $true
    }
  }
}
finally {
  Pop-Location
}

if ($updateSubmodules) {
    git submodule update --init --recursive
    git submodule foreach --recursive git checkout main
    git submodule foreach --recursive git pull
}
