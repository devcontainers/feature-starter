git update-index --add --chmod=+x "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run"
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/scripts" -Filter "*.sh" | ForEach-Object { git update-index --add --chmod=+x $_.FullName }
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/src" -Filter "*.sh" | ForEach-Object { git update-index --add --chmod=+x $_.FullName }
Get-ChildItem -Recurse -Path "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/test" -Filter "*.sh" | ForEach-Object { git update-index --add --chmod=+x $_.FullName }
