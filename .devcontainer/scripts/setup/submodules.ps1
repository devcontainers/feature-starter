# Update submodules
Push-Location "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT"
try {
  git submodule foreach --recursive git pull
  if ($LASTEXITCODE -ne 0) { throw "Exit code is $LASTEXITCODE" }
} catch {
  git submodule sync --recursive
  git submodule update --init --recursive
  git submodule foreach --recursive git checkout main
} finally {
  git submodule foreach --recursive git pull
  Pop-Location
}
