& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" -scriptPath devspace -script clean
docker system prune -a -f --volumes
