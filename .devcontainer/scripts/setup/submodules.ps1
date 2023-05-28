# Update submodules
$initSubmodules = $false
$submodulePath = "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT\.devcontainer\dependencies\devcontainers\features"
if (Test-Path $submodulePath) {
  $directoryInfo = Get-ChildItem $submodulePath | Measure-Object
  if ($directoryInfo.count -eq 0) {
    $initSubmodules = $true
  }
}

Push-Location "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT"
try {
  if ($initSubmodules) {
    git submodule sync --recursive
    git submodule update --init --recursive
    git submodule foreach --recursive git checkout main
  }
  
  git submodule foreach --recursive git pull
} finally {
  Pop-Location
}
