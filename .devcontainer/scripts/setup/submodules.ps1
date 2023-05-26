# Update submodules
Push-Location "$DEVCONTAINER_FEATURES_PROJECT_ROOT"
try {
  git submodule sync --recursive
  git submodule update --init --recursive
  git submodule foreach --recursive git checkout main
  git submodule foreach --recursive git pull
}
finally {
  Pop-Location
}
